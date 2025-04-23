return {

    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },

    "nvim-treesitter/nvim-treesitter-context",

    'mfussenegger/nvim-jdtls',

    -- bind9 dns syntax highlighting
    "egberts/vim-syntax-bind-named",

    -- :CellularAutomaton make_it_rain
    -- :CellularAutomaton game_of_life
    "eandrju/cellular-automaton.nvim",

    {
        "christoomey/vim-tmux-navigator",
        -- not working on macos
        -- cmd = {
        --     "TmuxNavigateLeft",
        --     "TmuxNavigateDown",
        --     "TmuxNavigateUp",
        --     "TmuxNavigateRight",
        --     "TmuxNavigatePrevious",
        --     "TmuxNavigatorProcessList",
        -- },
        -- keys = {
        --     { "<c-h>",     "<cmd><C-U>TmuxNavigateLeft<cr>" },
        --     { "<c-j>",     "<cmd><C-U>TmuxNavigateDown<cr>" },
        --     { "<c-k>",     "<cmd><C-U>TmuxNavigateUp<cr>" },
        --     { "<c-i>",     "<cmd><C-U>TmuxNavigateRight<cr>" },
        --
        --     { "<M-Left>",  "<cmd>TmuxNavigateLeft<cr>" },
        --     { "<M-Down>",  "<cmd>TmuxNavigateDown<cr>" },
        --     { "<M-Up>",    "<cmd>TmuxNavigateUp<cr>" },
        --     { "<M-Right>", "<cmd>TmuxNavigateRight<cr>" },
        --
        --     { "<C-Left>",  "<cmd>TmuxNavigateLeft<cr>" },
        --     { "<C-Down>",  "<cmd>TmuxNavigateDown<cr>" },
        --     { "<C-Up>",    "<cmd>TmuxNavigateUp<cr>" },
        --     { "<C-Right>", "<cmd>TmuxNavigateRight<cr>" },
        -- },
    },

    "AndrewRadev/dealwithit.vim",

    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        init = function()
            -- vim.g.vimtex_compiler_latexmk = { aux_dir = "auxiliary" out_dir = "output" } -- configured in .latexmkrc file in project root
            vim.g.vimtex_quickfix_enabled = 0
        end
    },

    {
        'tamton-aquib/duck.nvim',
        config = function()
            vim.api.nvim_create_user_command('HatchDuck', function()
                require("duck").hatch("💩", 10)
            end, {})

            vim.api.nvim_create_user_command('HatchManyDucks', function(opts)
                local num_ducks = tonumber(opts.args) or 1
                for i = num_ducks, 1, -1 do
                    require("duck").hatch("💩", 10)
                end
            end, { nargs = 1 })

            vim.api.nvim_create_user_command('CookDuck', function()
                require("duck").cook()
            end, {})

            vim.api.nvim_create_user_command('CookAllDucks', function()
                require("duck").cook_all()
            end, {})
        end
    },

    {
        'rhysd/vim-syntax-christmas-tree'
    }
}
