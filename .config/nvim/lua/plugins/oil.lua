return {
    'stevearc/oil.nvim',

    opts = {},

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        -- open downloads dir
        vim.keymap.set("n", "<leader>do", function()
            local home_dir = os.getenv("HOME")
            local downloads_dir = home_dir .. "/Downloads"
            require('oil').open(downloads_dir)
        end, { silent = true })

        -- open kbase dir
        vim.keymap.set("n", "<leader>bk", function()
            local kbase_dir = os.getenv("H8_KBASE_DIR")
            if kbase_dir then
                require('oil').open(kbase_dir)
            else
                print("Environment variable H8_KBASE_DIR is not set. (view readme for more info")
            end
        end, { silent = true })

        -- open data dir
        vim.keymap.set("n", "<leader>od", function()
            local kbase_dir = os.getenv("H8_DATA_DIR")
            if kbase_dir then
                require('oil').open(kbase_dir)
            else
                print("Environment variable H8_DATA_DIR is not set. (view readme for more info")
            end
        end, { silent = true })

        -- open cloud
        vim.keymap.set("n", "<leader>oc", function()
            local kbase_dir = os.getenv("H8_CLOUD_DIR")
            if kbase_dir then
                require('oil').open(kbase_dir)
            else
                print("Environment variable H8_CLOUD_DIR is not set. (view readme for more info")
            end
        end, { silent = true })

        -- open floating oil buffer
        vim.keymap.set("n", "<leader>of", function()
            local current_file_dir = vim.fn.expand('%:p:h')
            require('oil').open_float(current_file_dir)
        end, { silent = true })

        -- change current oil buffer to nvim root directory
        vim.keymap.set("n", "<leader>cd", function()
            local cur_dir = require("oil").get_current_dir();
            if cur_dir ~= nil then
                vim.api.nvim_set_current_dir(cur_dir)
                print("Changed root to: " .. cur_dir)
            else
                print("Current buffer is not associated with a file")
            end
        end, { silent = true })

        -- extract archive under cursor
        vim.keymap.set("n", "<leader>ea", function()
            local oil = require('oil')
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
                return
            end
            local path = dir .. entry.name

            -- Check if the entry is a file and if it's an archive (e.g., .zip, .tar.gz)
            if vim.fn.isdirectory(path) == 0 then
                local extract_dir = dir

                -- create command
                local command = nil
                if string.match(entry.name, "%.zip$") then
                    local archive_name = string.gsub(entry.name, "%.zip$", "")
                    extract_dir = dir .. archive_name
                    command = string.format("unzip -q -d %s %s", vim.fn.shellescape(extract_dir),
                        vim.fn.shellescape(path))
                elseif string.match(entry.name, "%.tar.gz$") or string.match(entry.name, "%.tgz$") then
                    command = string.format("mkdir -p %s && tar -xzf %s -C %s", vim.fn.shellescape(extract_dir),
                        vim.fn.shellescape(path), vim.fn.shellescape(extract_dir))
                elseif string.match(entry.name, "%.tar.bz2$") or string.match(entry.name, "%.tbz2$") then
                    command = string.format("mkdir -p %s && tar -xjf %s -C %s", vim.fn.shellescape(extract_dir),
                        vim.fn.shellescape(path), vim.fn.shellescape(extract_dir))
                elseif string.match(entry.name, "%.tar$") then
                    command = string.format("mkdir -p %s && tar -xf %s -C %s", vim.fn.shellescape(extract_dir),
                        vim.fn.shellescape(path), vim.fn.shellescape(extract_dir))
                else
                    print("Unsupported archive format:", entry.name)
                    return
                end

                -- execute command
                vim.cmd("!" .. command) -- execute command in vim cmd
                vim.cmd("edit")         -- refreshing buffer
            else
                print("invalid archive")
            end
        end, { silent = true })

        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ["<C-h>"]       = false,
                ["<C-l>"]       = false,
                ["<C-p>"]       = false,
                ["<C-r>"]       = "actions.refresh",
                ["q"]           = "actions.close",
                ["<leader>mao"] = function()
                    local oil = require("oil")
                    local filename = oil.get_cursor_entry().name
                    local dir = oil.get_current_dir()
                    oil.close()

                    local img_clip = require("img-clip")
                    img_clip.paste_image({}, dir .. filename)
                end
            },
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 200,
                max_height = 50,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                preview_split = "auto",
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf)
                    return conf
                end,
            },
        })

        -- function custom_action()
        --     local oil = require('oil')
        --     local entry = oil.get_cursor_entry()
        --     local dir = oil.get_current_dir()
        --     if not entry or not dir then
        --         return
        --     end
        --     local path = dir .. entry.name
        -- end

        -- Function to set the current Oil buffer directory as the Neovim root directory
        -- function set_oil_root()
        --     local cur_dir = require("oil").get_current_dir();
        --     if cur_dir ~= nil then
        --         vim.api.nvim_set_current_dir(cur_dir)
        --         print("Changed root to: " .. cur_dir)
        --     else
        --         print("Current buffer is not associated with a file")
        --     end
        -- end

        -- Map the custom action to a key in normal mode when in oil.nvim buffer
        -- vim.api.nvim_set_keymap('n', '<leader>cd', [[:lua set_oil_root()<CR>]], { noremap = true, silent = true })


        -- Map the custom action to a key in normal mode when in oil.nvim buffer
        -- vim.api.nvim_set_keymap('n', '<leader>cab', [[:lua custom_action()<CR>]], { noremap = true, silent = true })
    end,
}
