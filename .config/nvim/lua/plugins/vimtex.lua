return {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    init = function()
        -- vim.g.vimtex_compiler_latexmk = { aux_dir = "auxiliary" out_dir = "output" } -- configured in .latexmkrc file in project root
        vim.g.vimtex_quickfix_enabled = 0
    end
}
