-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- fuzzy finder functionality
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- commenting lines using commands
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- rose pine colorscheme
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    -- shows code errors of file in a list
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    -- syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,}
        use("nvim-treesitter/playground") -- should be integrated in neovim by default

        -- harpoon - fast file access
        use("theprimeagen/harpoon")

        -- refactoring from primeagen (not complet - only few languages)
        use("theprimeagen/refactoring.nvim")

        -- visualizes the undotree
        use("mbbill/undotree")

        -- running git commands in vim using :Git
        use("tpope/vim-fugitive")

        -- gues: keeps function name on top when scrolling
        use("nvim-treesitter/nvim-treesitter-context");

        -- lsp
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-nvim-lua'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
            }
        }

        -- java lsp
        use ('mfussenegger/nvim-jdtls')

        -- puts current buffer into floating window
        use("folke/zen-mode.nvim")

        -- useless but funny
        -- :CellularAutomaton make_it_rain
        -- :CellularAutomaton game_of_life
        use("eandrju/cellular-automaton.nvim")

        -- can replace characters in view (.env file variables are shown as *****)
        use("laytan/cloak.nvim")

        -- navigation with tmux and nvim using <Ctrl>+<j,k,l,h>
        use("christoomey/vim-tmux-navigator")

        -- markdown preview
        use({
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
        })
        use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
        -- use {'iamcco/markdown-preview.nvim'}

        -- sql
        use("tpope/vim-dadbod")
        use("kristijanhusak/vim-dadbod-ui")
        use("kristijanhusak/vim-dadbod-completion")

        -- latex
        use({
            "lervag/vimtex",
            lazy = false,     -- we don't want to lazy load VimTeX
            -- tag = "v2.15", -- uncomment to pin to a specific release
            init = function()
                -- VimTeX configuration goes here
            end
        })
        use("icewind/ltex-client.nvim")

    end)

