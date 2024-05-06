return {
    -- fuzzy finder functionality
    -- {
    --     'nvim-telescope/telescope.nvim', version = '0.1.3',
    --     -- or                            , branch = '0.1.x',
    --     dependencies = { {'nvim-lua/plenary.nvim'} }
    -- },

    -- commenting lines using commands
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },

    -- shows code errors of file in a list
    -- {
    --     "folke/trouble.nvim",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     opts = {
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --     }
    -- },

    -- syntax highlighting
    -- {
    --     'nvim-treesitter/nvim-treesitter',
    --     build = function()
    --         local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    --         ts_update()
    --     end,},
        "nvim-treesitter/playground", -- should be integrated in neovim by default

        -- harpoon - fast file access
        "theprimeagen/harpoon",

        -- refactoring from primeagen (not complet - only few languages)
        -- "theprimeagen/refactoring.nvim",

        -- visualizes the undotree
        -- "mbbill/undotree",

        -- running git commands in vim using :Git
        -- "tpope/vim-fugitive",

        -- gues: keeps function name on top when scrolling
        "nvim-treesitter/nvim-treesitter-context",

        -- lsp
        -- {
        --     'VonHeikemen/lsp-zero.nvim',
        --     branch = 'v1.x',
        --     dependencies = {
        --         -- LSP Support
        --         {'neovim/nvim-lspconfig'},
        --         {'williamboman/mason.nvim'},
        --         {'williamboman/mason-lspconfig.nvim'},
        --
        --         -- Autocompletion
        --         {'hrsh7th/nvim-cmp'},
        --         {'hrsh7th/cmp-buffer'},
        --         {'hrsh7th/cmp-path'},
        --         {'saadparwaiz1/cmp_luasnip'},
        --         {'hrsh7th/cmp-nvim-lsp'},
        --         {'hrsh7th/cmp-nvim-lua'},
        --
        --         -- Snippets
        --         {'L3MON4D3/LuaSnip'},
        --         {'rafamadriz/friendly-snippets'},
        --     }
        -- },

        -- java lsp
        'mfussenegger/nvim-jdtls',

        -- puts current buffer into floating window
        -- "folke/zen-mode.nvim",

        -- less but funny
        -- :CellularAutomaton make_it_rain
        -- :CellularAutomaton game_of_life
        "eandrju/cellular-automaton.nvim",

        -- can replace characters in view (.env file variables are shown as *****)
        -- "laytan/cloak.nvim",

        -- navigation with tmux and nvim using <Ctrl>+<j,k,l,h>
        "christoomey/vim-tmux-navigator",

        -- markdown preview
        {
            "iamcco/markdown-preview.nvim",
            build = function() vim.fn["mkdp#util#install"]() end,
        },
        { "iamcco/markdown-preview.nvim", build = "cd app && npm install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, },
        --  {'iamcco/markdown-preview.nvim'}

        -- sql
        "tpope/vim-dadbod",
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",

        -- latex
        {
            "lervag/vimtex",
            lazy = false,     -- we don't want to lazy load VimTeX
            -- tag = "v2.15", -- uncomment to pin to a specific release
            init = function()
                -- VimTeX configuration goes here
            end
        },
        -- ("icewind/ltex-client.nvim")

        -- sorround highlighted text
        -- note: removed config function beca it set the S key and this was a problem with leap.nvim
        -- setup functino is now called in after/plugin directory
        -- {
        --     "kylechui/nvim-surround",
        --     version = "*", -- Use for stability; omit to  `main` branch for the latest features
        -- },

        -- "ggandor/leap.nvim",

}
