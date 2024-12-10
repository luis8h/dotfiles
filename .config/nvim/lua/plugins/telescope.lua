return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.3',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
        local builtin = require('telescope.builtin')

        -- find files (no hidden)
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find files in working directory (no hidden)" })

        -- find files (include hidden)
        vim.keymap.set('n', '<leader>fa', function()
            builtin.find_files({
                hidden = true, -- Include hidden files
            })
        end, { desc = "Telescope find files in working directory (hidden)" })

        -- find all files (whole system) - bad performance
        vim.keymap.set('n', '<leader>fr', function()
            builtin.find_files({
                hidden = true, -- Include hidden files
                cwd = "/",
            })
        end, { desc = "Telescope find files in root" })

        -- find files in home dir
        vim.keymap.set('n', '<leader>fh', function()
            builtin.find_files({
                hidden = true, -- Include hidden files
                cwd = "~",
            })
        end, { desc = "Telescope find files in home" })

        -- find files in data directory (only if env variable is set)
        vim.keymap.set('n', '<leader>fd', function()
            local data_dir = os.getenv('DATA_DIR')
            if data_dir then
                builtin.find_files({
                    hidden = true, -- Include hidden files
                    cwd = data_dir,
                })
            else
                print("Environment variable DATA_DIR is not set. (view readme for more info)")
            end
        end, { desc = "Telescope find files in data" })

        -- find files in kbase directory (only if env variable is set)
        vim.keymap.set('n', '<leader>fb', function()
            local kbase_dir = os.getenv('KBASE_DIR')
            if kbase_dir then
                builtin.find_files({
                    hidden = false, -- Include hidden files
                    cwd = kbase_dir,
                })
            else
                print("Environment variable KBASE_DIR is not set. (view readme for more info)")
            end
        end, { desc = "Telescope find files in kbase" })

        -- find directories in working dir (no hidden)
        vim.keymap.set('n', '<leader>df', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--follow", "." },
            })
        end, { desc = "Telescope find directories in working dir (no hidden)" })

        -- find directories in working dir (including hidden)
        vim.keymap.set('n', '<leader>da', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
            })
        end, { desc = "Telescope find directories in working dir (hidden)" })

        -- find directories in home dir
        vim.keymap.set('n', '<leader>dh', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                cwd = os.getenv('HOME')
            })
        end, { desc = "Telescope find directories in home" })

        -- find all directories on system
        vim.keymap.set('n', '<leader>dr', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                cwd = '/'
            })
        end, { desc = "Telescope find directories in root" })

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
        end, { desc = "Telescope find directories in data" })

        -- find directories in download dir
        vim.keymap.set('n', '<leader>dl', function()
            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                cwd = os.getenv('HOME') .. '/Downloads'
            })
        end, { desc = "Telescope find directories in downloads" })

        -- find files in current oil dir
        vim.keymap.set('n', '<leader>fc', function()
            local oil = require('oil')

            local cwd = oil.get_current_dir()

            builtin.find_files({ cwd = cwd })
        end, { desc = "Telescope find files in Oil directory" })

        -- find directories in current oil dir
        vim.keymap.set('n', '<leader>dc', function()
            local oil = require('oil')
            local cwd = oil.get_current_dir()

            builtin.find_files({
                prompt_title = "Find Directories",
                find_command = { "fd", "--type", "d", "--hidden", "--follow", "." },
                cwd = cwd
            })
        end, { desc = "Telescope find directories in Oil directory" })

        -- find files added to git
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Telescope find files added to git" })

        -- static grep in cwd (no hidden)
        vim.keymap.set('n', '<leader>sf', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "static grep in cwd (no hidden)" })

        -- static grep in cwd (hidden)
        vim.keymap.set('n', '<leader>sa', function()
            require('telescope.builtin').grep_string({
                search = vim.fn.input("Grep > "),
                additional_args = function(opts)
                    return { "--hidden" }
                end
            })
        end, { desc = "static grep in cwd (hidden)" })

        -- search help_tags
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        -- live grep in cwd (no hidden)
        vim.keymap.set('n', '<leader>lf', builtin.live_grep, { desc = "live grep in cwd (no hidden)" })

        -- live grep in cwd (hidden)
        vim.keymap.set('n', '<leader>la', function()
            builtin.live_grep({
                additional_args = function(opts)
                    return { "--hidden" }
                end
            })
        end, { desc = "live grep in cwd (hidden)" })

        -- search open buffers
        vim.keymap.set('n', '<leader>bf', builtin.buffers, { desc = "Telescope open buffers" })
    end,
}
