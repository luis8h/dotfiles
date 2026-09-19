return {
    "saghen/blink.cmp",
    dependencies = {
        { "rafamadriz/friendly-snippets" },
        {
            'saghen/blink.compat', -- only kept for cmp-dbee
            version = '2.*',
            lazy = true,
            opts = {},
        },
        {
            "xzbdmw/colorful-menu.nvim",
            opts = {},
        },
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = { enabled = true },
        appearance = { nerd_font_variant = "mono" },
        completion = {
            keyword = { range = 'prefix' },
            list = {
                selection = { preselect = false, auto_insert = true },
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            per_filetype = {
                sql = { "dbee", "buffer" },
                -- markdown no longer needs obsidian entries; obsidian.nvim
                -- injects itself automatically when active
            },
            providers = {
                dbee = { name = "cmp-dbee", module = "blink.compat.source" },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
        require("blink.cmp").setup(opts)
        vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
    end,
}
