local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.g.markdown_folding = 1

-- fix for colorizer plugin throwing an error at startup
vim.opt.termguicolors = true

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})


require("luis8h")


local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Show file content from a branch
local function preview_file_from_branch(branch, filepath)
  vim.cmd("vnew")
  local output = vim.fn.systemlist("git show " .. branch .. ":" .. filepath)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
  vim.bo[0].filetype = vim.fn.fnamemodify(filepath, ":e")
  vim.bo[0].buftype = 'nofile'
  vim.bo[0].bufhidden = 'wipe'
  vim.bo[0].swapfile = false
  vim.bo[0].modifiable = false
end

-- Custom Telescope workflow
local function GitBrowseBranchFile()
  pickers.new({}, {
    prompt_title = "Git Branches",
    finder = finders.new_oneshot_job({ "git", "branch", "--all", "--format=%(refname:short)" }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        local branch = selection[1]

        -- Manually close the picker safely
        require("telescope.actions")._close(prompt_bufnr, true)

        -- Schedule the second picker after UI cleanup
        vim.schedule(function()
          pickers.new({}, {
            prompt_title = "Files in " .. branch,
            finder = finders.new_oneshot_job({ "git", "ls-tree", "-r", "--name-only", branch }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(file_bufnr, _)
              actions.select_default:replace(function()
                local file_entry = action_state.get_selected_entry()
                local filepath = file_entry[1]
                require("telescope.actions")._close(file_bufnr, true)

                -- Defer preview to avoid redraw conflict
                vim.schedule(function()
                  preview_file_from_branch(branch, filepath)
                end)
              end)
              return true
            end,
          }):find()
        end)
      end)
      return true
    end,
  }):find()
end

-- Register as command
vim.api.nvim_create_user_command("GitBrowseFileFromBranch", GitBrowseBranchFile, {})


local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local previewers   = require("telescope.previewers")
local conf         = require("telescope.config").values
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function GitBrowseFilesFromCommit()
  -- 1) pick a branch
  pickers.new({}, {
    prompt_title = "Git Branches",
    finder       = finders.new_oneshot_job({ "git", "branch", "--all", "--format=%(refname:short)" }),
    sorter       = conf.generic_sorter({}),
    attach_mappings = function(branch_bufnr, _)
      actions.select_default:replace(function()
        local raw_branch = action_state.get_selected_entry()[1]
        actions._close(branch_bufnr, true)
        local branch = raw_branch:match("^remotes/(.+)") or raw_branch

        vim.schedule(function()
          -- 2) pick a commit
          local log_cmd = {
            "git", "log", branch,
            "--pretty=format:%h - %s",
          }
          -- capture via systemlist
          local commits = vim.fn.systemlist(log_cmd)
          if vim.tbl_isempty(commits) then
              vim.notify("No commits on " .. branch, vim.log.levels.WARN)
            return
          end

          pickers.new({
            prompt_title = "Commits in " .. branch,
          }, {
            finder    = finders.new_table { results = commits },
            sorter    = conf.generic_sorter({}),
            previewer = previewers.new_termopen_previewer({
              get_command = function(entry)
                local sha = entry.value:match("^[^ ]+")
                return { "git", "show", "--color=always", sha }
              end,
            }),
            attach_mappings = function(commit_bufnr, _)
              actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                local sha   = entry.value:match("^[^ ]+")
                actions._close(commit_bufnr, true)

                vim.schedule(function()
                  -- 3) pick a file in that commit
                  local ls_cmd = { "git", "ls-tree", "-r", "--name-only", sha }
                  pickers.new({
                    prompt_title = "Files in commit " .. sha,
                  }, {
                    finder    = finders.new_oneshot_job(ls_cmd),
                    sorter    = conf.generic_sorter({}),
                    previewer = previewers.new_termopen_previewer({
                      get_command = function(fentry)
                        local file = fentry.value
                        return { "git", "show", string.format("%s:%s", sha, file) }
                      end,
                    }),
                    attach_mappings = function(file_bufnr, _)
                      actions.select_default:replace(function()
                        local fentry = action_state.get_selected_entry()
                        local file   = fentry.value
                        actions._close(file_bufnr, true)
                        -- open final buffer
                        vim.schedule(function()
                          vim.cmd("vnew")
                          local lines = vim.fn.systemlist({ "git", "show", sha .. ":" .. file })
                          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
                          vim.bo[0].filetype  = vim.fn.fnamemodify(file, ":e")
                          vim.bo[0].buftype    = "nofile"
                          vim.bo[0].bufhidden  = "wipe"
                          vim.bo[0].modifiable = false
                        end)
                      end)
                      return true
                    end,
                  }):find()
                end)
              end)
              return true
            end,
          }):find()
        end)
      end)
      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command("GitBrowseFilesFromCommit", GitBrowseFilesFromCommit, {})

