return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup {
            ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "java", "python" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = { "latex" },
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    ccope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        }
    end,
}
