
return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.3',
    dependencies = { {'nvim-lua/plenary.nvim'} },
    config = function()

        local builtin = require('telescope.builtin')

        -- find files (no hidden)
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

        -- find files (include hidden)
        vim.keymap.set('n', '<leader>p.', function()
            builtin.find_files({
                hidden = true, -- Include hidden files
            })
        end, {})

        -- find all files (whole system) - bad performance
        vim.keymap.set('n', '<leader>pa', function()
            builtin.find_files({
                hidden = true, -- Include hidden files
                cwd = "/",
            })
        end, {})

        -- find files in home dir
        vim.keymap.set('n', '<leader>ph', function()
            builtin.find_files({
                hidden = true, -- Include hidden files
                cwd = "~",
            })
        end, {})

        -- find files in data directory (only if env variable is set)
        vim.keymap.set('n', '<leader>pd', function()
            local data_dir = os.getenv('DATA_DIR')
            if data_dir then
                builtin.find_files({
                    hidden = true, -- Include hidden files
                    cwd = data_dir,
                })
            else
                print("Environment variable DATA_DIR is not set. (view readme for more info)")
            end
        end, {})

        -- find directories in working dir
        vim.keymap.set('n', '<leader>df', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
            })
        end, {})

        -- find directories in home dir
        vim.keymap.set('n', '<leader>dh', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                cwd = os.getenv('HOME')
            })
        end, {})

        -- find all directories on system
        vim.keymap.set('n', '<leader>da', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                cwd = '/'
            })
        end, {})

        -- find directories in data directory (only if env variable is set)
        vim.keymap.set('n', '<leader>dd', function()
            local data_dir = os.getenv('DATA_DIR')
            if data_dir then
                builtin.find_files({
                    prompt_title = "Find Directories",
                    cwd = data_dir,
                    find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                })
            else
                print("Environment variable DATA_DIR is not set. (view readme for more info)")
            end
        end, {})

        -- find directories in home dir
        vim.keymap.set('n', '<leader>dh', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                cwd = os.getenv('HOME')
            })
        end, {})

        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        vim.keymap.set('n', '<leader>psf', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        vim.keymap.set('n', '<leader>psa', function()
            require('telescope.builtin').grep_string({
                search = vim.fn.input("Grep > "),
                additional_args = function(opts)
                    return {"--hidden"}
                end
            })
        end)

        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

        vim.keymap.set('n', '<leader>pb', builtin.buffers, {})

    end,
}


