-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.

-- aucommand on every lsp attach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- autocompletion
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-Space>', function() vim.lsp.completion.get() end)
        end

        -- keymaps
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, { desc = 'Show diagnostics in float' })
        vim.keymap.set('n', '<leader>vf', function() vim.lsp.buf.format() end)
        vim.keymap.set('n', '<leader>va', function() vim.lsp.buf.code_action() end)
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
})
