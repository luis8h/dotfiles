-- Define a function to set syntax to cpp when opening .asy files
-- not working until now... (workaround: shortcut below)
vim.cmd('set syntax=cpp')

-- for asymptote converting to pdf
vim.keymap.set("n", "<leader>asy", "<cmd>w<CR>:!asy -f pdf %<CR>", { silent = true })
vim.keymap.set("n", "<leader>cpp", "<cmd>:set syntax=cpp<CR>", { silent = true })
