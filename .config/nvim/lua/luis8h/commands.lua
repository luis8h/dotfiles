local pickers = require("luis8h.pickers")

vim.api.nvim_create_user_command("TelescopeGitFilesFromBranch", pickers.git_files_from_branch, {})
vim.api.nvim_create_user_command("TelescopeGitFilesFromCommit", pickers.git_files_from_commit, {})
