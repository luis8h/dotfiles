
-- also set in lazy config
vim.g.mapleader = " "

-- open file explorer
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }) -- for oil
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- for netrw
-- remap netrw refresh
-- vim.keymap.set('n', '<unique><C-r>', '<Plug>NetrwRefresh')


-- move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- append line below
vim.keymap.set("n", "J", "mzJ`z")


-- when using C-u automaticly center vertically
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- when searching center vertically
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- replace selected text without overwriting clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])


-- yank into global register
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])


-- deletes into _ register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])


-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")


-- unmapping Q
vim.keymap.set("n", "Q", "<nop>")


-- format file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


-- commentet out for tmux vim navigator to work
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


-- search/replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- chmod file to be executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


-- make it rain automaton
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");


-- spelling
vim.keymap.set("n", "<leader>z", function()
    vim.cmd("setlocal spell")
end)
vim.keymap.set("n", "zde", function()
    vim.cmd("setlocal spelllang=de")
end)
vim.keymap.set("n", "zen", function()
    vim.cmd("setlocal spelllang=en_us")
end)