return {
    'stevearc/oil.nvim',

    opts = {},

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        -- open downloads dir
        vim.keymap.set("n", "<leader>qh", function()
            local home_dir = os.getenv("HOME")
            require('oil').open(home_dir)
        end, { silent = true })

        -- open downloads dir
        vim.keymap.set("n", "<leader>qd", function()
            local home_dir = os.getenv("HOME")
            local downloads_dir = home_dir .. "/Downloads"
            require('oil').open(downloads_dir)
        end, { silent = true })

        -- open kbase dir
        vim.keymap.set("n", "<leader>qb", function()
            local kbase_dir = os.getenv("H8_KBASE_DIR")
            if kbase_dir then
                require('oil').open(kbase_dir)
            else
                print("Environment variable H8_KBASE_DIR is not set. (view readme for more info")
            end
        end, { silent = true })

        -- open data dir
        vim.keymap.set("n", "<leader>qa", function()
            local kbase_dir = os.getenv("H8_DATA_DIR")
            if kbase_dir then
                require('oil').open(kbase_dir)
            else
                print("Environment variable H8_DATA_DIR is not set. (view readme for more info")
            end
        end, { silent = true })

        -- open cloud
        vim.keymap.set("n", "<leader>qc", function()
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

        local pickers = require("telescope.pickers")
        local entry_display = require("telescope.pickers.entry_display")
        local oil = require("oil")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        -- Parse a .desktop file and return a table with relevant fields.
        -- Returns nil if it's not an Application or it should be ignored.
        local function parse_desktop_file(path)
            local f, err = io.open(path, "r")
            if not f then return nil end

            local inside_desktop_entry = false
            local t = { path = path, id = nil, name = nil, exec = nil, nodisplay = false, type = nil }

            for line in f:lines() do
                -- trim
                local s = line:match("^%s*(.-)%s*$")
                if s ~= "" then
                    -- section header
                    if s:match("^%[") then
                        inside_desktop_entry = (s:lower() == "[desktop entry]")
                    elseif inside_desktop_entry then
                        local k, v = s:match("^([^=]+)=(.*)$")
                        if k and v then
                            k = k:match("^%s*(.-)%s*$")
                            v = v:match("^%s*(.-)%s*$")
                            if k == "Type" then
                                t.type = v
                                if v ~= "Application" then
                                    -- not an application -> bail
                                    f:close()
                                    return nil
                                end
                            elseif k == "NoDisplay" and (v == "true" or v == "1") then
                                t.nodisplay = true
                            elseif k == "Name" and not t.name then
                                -- take first Name= line (no localization handling for simplicity)
                                t.name = v
                            elseif k == "Exec" and not t.exec then
                                t.exec = v
                            end
                        end
                    end
                end
            end

            f:close()

            -- require at least a name and that it's an Application
            if t.type ~= "Application" or not t.name then
                return nil
            end

            -- compute desktop id (basename without .desktop)
            local id = path:match("([^/]+)%.desktop$")
            if not id then return nil end
            t.id = id

            return t
        end

        -- Get available apps from standard dirs, dedupe, prefer visible ones
        local function get_available_desktop_apps()
            local app_dirs = {
                "/usr/share/applications",
                vim.fn.expand("~/.local/share/applications"),
            }

            local apps_by_id = {}

            for _, dir in ipairs(app_dirs) do
                if vim.fn.isdirectory(dir) == 1 then
                    -- use Vim's glob to avoid shell escaping issues
                    local files = vim.fn.globpath(dir, "*.desktop", false, true) -- returns list
                    for _, file in ipairs(files) do
                        local parsed = parse_desktop_file(file)
                        if parsed then
                            local existing = apps_by_id[parsed.id]
                            if not existing then
                                apps_by_id[parsed.id] = parsed
                            else
                                -- prefer the one with NoDisplay = false (visible launchers)
                                if existing.nodisplay and not parsed.nodisplay then
                                    apps_by_id[parsed.id] = parsed
                                end
                                -- otherwise keep existing (could add more heuristics)
                            end
                        end
                    end
                end
            end

            local apps = {}
            for id, meta in pairs(apps_by_id) do
                table.insert(apps, meta)
            end

            table.sort(apps, function(a, b)
                return (a.name:lower() or "") < (b.name:lower() or "")
            end)

            return apps
        end

        -- The telescope picker
        local function open_with_telescope()
            local entry = oil.get_cursor_entry()
            if not entry then
                vim.notify("No entry under cursor", vim.log.levels.WARN)
                return
            end

            -- Build full path to selected file/dir. oil.get_current_dir() returns dir with trailing slash.
            local cwd = oil.get_current_dir() or vim.loop.cwd() .. "/"
            local filepath = cwd .. entry.name

            local apps = get_available_desktop_apps()
            if vim.tbl_isempty(apps) then
                vim.notify("No .desktop applications found", vim.log.levels.WARN)
                return
            end

            local displayer = entry_display.create({
                separator = " ▏ ",
                items = {
                    { width = 40 },
                    { remaining = true },
                },
            })

            local function make_entry(item)
                return {
                    value = item,
                    display = function(entry)
                        return displayer({
                            entry.value.name,
                            "(" .. entry.value.id .. ")",
                        })
                    end,
                    ordinal = (item.name or "") .. " " .. (item.id or ""),
                }
            end

            pickers.new({}, {
                prompt_title = "Open with...",
                finder = finders.new_table {
                    results = apps,
                    entry_maker = make_entry,
                },
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        if not selection or not selection.value then return end
                        local app_id = selection.value.id
                        -- Use gtk-launch to open the file with the chosen desktop id
                        -- gtk-launch accepts: gtk-launch <desktop-id> [files...]
                        -- We pass the filepath as a single arg.
                        vim.fn.jobstart({ "gtk-launch", app_id, filepath }, { detach = true })
                    end)
                    return true
                end,
            }):find()
        end

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
                ["gX"]          = open_with_telescope,
                ["<leader>mao"] = function()
                    local oil = require("oil")
                    local dir = oil.get_current_dir()

                    if not dir then
                        vim.notify("No directory found (are you inside Oil?)", vim.log.levels.WARN)
                        return
                    end

                    -- ask for a file name
                    local filename = vim.fn.input("File name (leave empty for 'pasted'): ")
                    if filename == "" then
                        filename = "pasted"
                    end

                    -- run betterpaste
                    vim.fn.jobstart({ "betterpaste", dir .. "/" .. filename }, {
                        stdout_buffered = true,
                        stderr_buffered = true,
                        on_stdout = function(_, data)
                            if data and #data > 0 then
                                vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
                            end
                        end,
                        on_stderr = function(_, data)
                            if data and #data > 0 then
                                vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
                            end
                        end,
                        on_exit = function()
                            -- refresh oil buffer
                            require("oil.actions").refresh.callback()
                        end,
                    })
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
