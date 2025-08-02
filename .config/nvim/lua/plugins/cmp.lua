-- ===========================
-- Autocompletion
-- ===========================
return {
    "saghen/blink.cmp",
    dependencies = {
        { "rafamadriz/friendly-snippets" },
        {
            'saghen/blink.compat',
            -- use v2.* for blink.cmp v1.*
            version = '2.*',
            -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
            lazy = true,
            -- make sure to set opts so that lazy.nvim calls blink.compat's setup
            opts = {},
        },
        {
            "xzbdmw/colorful-menu.nvim",
            opts = {},
        },
    },
    version = "1.*",
    ---
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        cmdline = {
            enabled = true,
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            keyword = { range = 'prefix' },
            -- ghost_text = {
            --     show_with_selection = true,
            --     show_with_menu = true,
            --     show_without_menu = false,
            --     show_without_selection = false,
            --     enabled = true,
            -- },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
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
                -- Dbee
                sql = { "dbee", "buffer" }, -- Add any other source to include here
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


-- old setup with nvim-cmp
-- return {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "saadparwaiz1/cmp_luasnip",
--         "L3MON4D3/LuaSnip",
--         "rafamadriz/friendly-snippets",
--         "onsails/lspkind.nvim",
--     },
--     config = function()
--         local cmp = require("cmp")
--         local luasnip = require("luasnip")
--         local lspkind = require("lspkind")
--
--         require("luasnip.loaders.from_vscode").lazy_load()
--
--         cmp.setup({
--             snippet = {
--                 expand = function(args)
--                     luasnip.lsp_expand(args.body)
--                 end,
--             },
--             mapping = cmp.mapping.preset.insert({
--                 ["<C-n>"] = cmp.mapping.select_next_item(),
--                 ["<C-p>"] = cmp.mapping.select_prev_item(),
--                 ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--                 ["<C-e>"] = cmp.mapping.abort(),
--             }),
--             sources = cmp.config.sources({
--                 { name = "nvim_lsp" },
--                 { name = "luasnip" },
--                 { name = "path" },
--                 { name = "buffer" },
--             }),
--             formatting = {
--                 format = lspkind.cmp_format({
--                     mode = "symbol_text", -- Show symbol + text
--                     maxwidth = 50,
--                     ellipsis_char = "...",
--                 }),
--             },
--         })
--     end,
-- }
