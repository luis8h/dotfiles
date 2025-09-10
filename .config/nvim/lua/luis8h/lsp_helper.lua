local M = {}

-- extends the current config of ltex ls with the new_settings
function M.restart_ltex_plus_with(new_settings)
    local lsp_name = "ltex_plus"

    -- Stop existing clients
    for _, client in ipairs(vim.lsp.get_clients({ name = lsp_name })) do
        client:stop()
    end

    -- Get the existing registered config
    local ok, existing_config = pcall(function()
        return vim.lsp.get_clients({ name = lsp_name })[1].config
    end)

    local current_settings = {}
    if ok and existing_config and existing_config.settings and existing_config.settings.ltex then
        current_settings = existing_config.settings.ltex
    end

    -- Merge the new settings into the existing settings
    local merged_settings = vim.tbl_deep_extend("force", current_settings, new_settings)

    -- Update config
    vim.lsp.config(lsp_name, {
        settings = {
            ltex = merged_settings,
        },
    })

    -- Restart LSP
    vim.lsp.enable(lsp_name)
end



-- This function will get the diagnostics for the current line, format them, and yank them.
function M.yank_diagnostics()
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

return M
