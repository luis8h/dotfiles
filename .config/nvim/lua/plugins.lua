return {

    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },

    "mg979/vim-visual-multi",

    "nvim-treesitter/nvim-treesitter-context",

    'mfussenegger/nvim-jdtls',

    -- :CellularAutomaton make_it_rain
    -- :CellularAutomaton game_of_life
    "eandrju/cellular-automaton.nvim",

    "christoomey/vim-tmux-navigator",

    {
        "lervag/vimtex",
        lazy = false,     -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here
        end
    },

}
