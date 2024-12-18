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

    "christoomey/vim-tmux-navigator",

    "AndrewRadev/dealwithit.vim",

    {
        "lervag/vimtex",
        lazy = false,     -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here
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
