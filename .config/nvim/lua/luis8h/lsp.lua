-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.


-- This function will get the diagnostics for the current line, format them, and yank them.
local yank_diagnostics = function()
    -- Get diagnostics for the current buffer and line.
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })

    -- If there are no diagnostics on the current line, do nothing.
    if #diagnostics == 0 then
        vim.notify("No diagnostics to yank.", vim.log.levels.INFO)
        return
    end

    -- Format the diagnostics into a single string.
    local formatted_diagnostics = ""
    for _, d in ipairs(diagnostics) do
        local severity_map = {
            [vim.diagnostic.severity.ERROR] = "ERROR",
            [vim.diagnostic.severity.WARN] = "WARNING",
            [vim.diagnostic.severity.INFO] = "INFO",
            [vim.diagnostic.severity.HINT] = "HINT",
        }
        local severity = severity_map[d.severity] or "UNKNOWN"
        local message = d.message:gsub("[\r\n]", " "):gsub("%s+", " "):gsub("^%s+", "") -- Clean up newlines and extra spaces
        formatted_diagnostics = formatted_diagnostics .. string.format("[%s] %s\n", severity, message)
    end

    -- Yank the formatted string into the system clipboard.
    vim.fn.setreg("+", formatted_diagnostics)
    vim.notify("Yanked diagnostics to clipboard.", vim.log.levels.INFO)
end

-- aucommand on every lsp attach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        -- keymaps
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, { desc = 'Show diagnostics in float' })
        vim.keymap.set('n', '<leader>vf', function() vim.lsp.buf.format() end)
        vim.keymap.set('n', '<leader>vy', yank_diagnostics, { desc = 'Yank diagnostics on current line' })
    end,
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Diagnostics
vim.diagnostic.config({
    virtual_text = {
        virt_text_pos = 'eol',
        format = function(diagnostic)
            local severity = {
                [vim.diagnostic.severity.ERROR] = "E",
                [vim.diagnostic.severity.WARN]  = "W",
                [vim.diagnostic.severity.INFO]  = "I",
                [vim.diagnostic.severity.HINT]  = "H",
            }
            local prefix = severity[diagnostic.severity] or ""
            return string.format("[%s] %s", prefix, diagnostic.message)
        end
    },
    float = {
        border = "rounded",
        source = "always"
    },
    signs = true,
    underline = true,
    severity_sort = true
})
