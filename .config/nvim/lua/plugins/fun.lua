return {
    -- :CellularAutomaton make_it_rain
    -- :CellularAutomaton game_of_life
    "eandrju/cellular-automaton.nvim",

    "AndrewRadev/dealwithit.vim",

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

    'rhysd/vim-syntax-christmas-tree'
}
