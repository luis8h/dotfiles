return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
        -- vim.g.vimtex_compiler_latexmk = { aux_dir = "auxiliary" out_dir = "output" } -- configured in .latexmkrc file in project root
        -- Disable the quickfix list for compiler output
        vim.g.vimtex_quickfix_enabled = 0

        -- Disable the log window (which is for debugging purposes)
        vim.g.vimtex_log_enabled = 0

        -- Prevent VimTeX from automatically opening the quickfix list on warnings or errors
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_open_on_error = 0
    end
}
