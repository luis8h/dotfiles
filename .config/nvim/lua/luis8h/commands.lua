local pickers = require("luis8h.pickers")

vim.api.nvim_create_user_command("TelescopeGitFilesFromBranch", pickers.git_files_from_branch, {})
vim.api.nvim_create_user_command("TelescopeGitFilesFromCommit", pickers.git_files_from_commit, {})

vim.api.nvim_create_user_command('JJTelescope', function(opts)
  local rev = opts.args

  -- Lazy load telescope modules so this doesn't break startup time
  local has_telescope, _ = pcall(require, "telescope")
  if not has_telescope then
    vim.notify("Telescope is not installed or available", vim.log.levels.ERROR)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "JJ Files (" .. rev .. ")",
    -- Use an async job to list all files in the given revision
    finder = finders.new_oneshot_job({ "jj", "file", "list", "-r", rev }, {}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, _)
      -- Override what happens when you press <CR>
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if not selection then return end

        local filepath = selection.value

        -- Fetch the file content directly from the revision
        local cmd = string.format("jj file show -r %s %s", vim.fn.shellescape(rev), vim.fn.shellescape(filepath))
        local output = vim.fn.systemlist(cmd)

        if vim.v.shell_error ~= 0 then
          vim.notify("JJ Error: " .. table.concat(output, "\n"), vim.log.levels.ERROR)
          return
        end

        -- Create a new vertical split
        vim.cmd('vnew')
        local buf = vim.api.nvim_get_current_buf()

        -- Inject the text and lock the buffer
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
        vim.bo[buf].buftype = 'nofile'
        vim.bo[buf].bufhidden = 'wipe'
        vim.bo[buf].swapfile = false
        vim.bo[buf].readonly = true
        vim.bo[buf].modifiable = false

        -- Automatically detect and apply correct syntax highlighting
        local ft = vim.filetype.match({ filename = filepath })
        if ft then
            vim.bo[buf].filetype = ft
        end

        -- Name the buffer so you know what you're looking at
        pcall(vim.api.nvim_buf_set_name, buf, string.format("jj://%s/%s", rev, filepath))
      end)
      return true
    end,
  }):find()
end, { nargs = 1 })
