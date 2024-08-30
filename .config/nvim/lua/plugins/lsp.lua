return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-cmdline' },
        { "kristijanhusak/vim-dadbod-completion" },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        -- write mason plugins here to install them automaticly (:so after update)
        -- use grey word behind plugin in :Mason view
        -- only lsp, linter (maybe csharpier manual installation)
        lsp.ensure_installed({
            -- 'tsserver',
            -- 'rust_analyzer',
            -- 'pyright',
            -- 'angularls',
            -- 'csharp_ls',
            -- 'jdtls',
            -- 'pyright',
            -- 'bufls',
            -- 'terraformls',
            -- 'texlab',
            'lua_ls',
            -- 'marksman',
            -- 'black',
            -- 'ruff',
            -- 'mypy',
        })

        -- Fix Undefined global 'vim'
        lsp.nvim_workspace()

        -- cmp setup
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ["<CR>"] = cmp.config.disable, -- disabled
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-y>"] = cmp.mapping.confirm(),
        })

        -- disabling keymaps
        cmp_mappings['<Tab>'] = nil
        cmp_mappings['<S-Tab>'] = nil

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        })

        -- keybinds
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
        vim.keymap.set("n", "<leader>vff", function() vim.lsp.buf.format({ async = true }) end)
        vim.keymap.set("v", "<leader>vfr", function()
            vim.lsp.buf.format({
                async = true,
                range = {
                    ['start'] = vim.api.nvim_buf_get_mark(0, "<"),
                    ['end'] = vim.api.nvim_buf_get_mark(0, ">"),
                }
            })
        end)



        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })


        local lspconfig = require('lspconfig')


        -----------------------------------------------------------------------
        -- python lsp ---------------------------------------------------------
        -----------------------------------------------------------------------
        require 'lspconfig'.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        -- formatter options
                        black = { enabled = true },
                        autopep8 = { enabled = false },
                        yapf = { enabled = false },
                        -- linter options
                        pylint = {
                            enabled = true,
                            executable = "pylint",
                            args = {
                                "--max-line-length=99",
                                "--disable=missing-module-docstring",
                                "--disable=missing-function-docstring",
                                "--disable=missing-class-docstring",
                                "--disable=line-too-long",
                            },
                        },
                        flake8 = {
                            enabled = true,
                            maxLineLength = 99,
                            ignore = {"E501"},
                        },
                        pyflakes = { enabled = false },
                        pycodestyle = { enabled = false },
                        -- type checker
                        pylsp_mypy = { enabled = true },
                        -- auto-completion options
                        jedi_completion = { fuzzy = true },
                        -- import sorting
                        pyls_isort = { enabled = true },
                    }
                }
            }
        }

        -----------------------------------------------------------------------
        -- opengl setup -------------------------------------------------------
        -----------------------------------------------------------------------

        -- Ensure correct filetype for .frag and .vert files
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = { "*.frag", "*.vert" },
            callback = function()
                vim.bo.filetype = "glsl"
            end
        })

        lspconfig.glsl_analyzer.setup({
            filetypes = { 'glsl', 'vert', 'frag' },
            on_attach = function(client, bufnr)
                -- Custom keymaps or settings for this language server
                local opts = { buffer = bufnr }
                -- vim.keymap.set('n', '<leader>gf', vim.lsp.buf.definition, opts)
                -- vim.keymap.set('n', '<leader>gh', vim.lsp.buf.hover, opts)
            end,
        })
    end,
}
