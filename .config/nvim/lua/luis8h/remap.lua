
-- also set in lazy config
vim.g.mapleader = " "


-- select all
vim.keymap.set("n", "==", "gg<S-v>G")


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

-- keep window centered when scrolling (uncommented because of scrolloff=999 in set.lua)
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "j", "jzz")
-- vim.keymap.set("n", "k", "kzz")
-- vim.keymap.set("n", "G", "Gzz")

-- Copy file paths
vim.keymap.set("n", "<leader>cf", "<cmd>let @+ = expand(\"%\")<CR>", { desc = "Copy File Name" })
vim.keymap.set("n", "<leader>cp", "<cmd>let @+ = expand(\"%:p\")<CR>", { desc = "Copy File Path" })

-- replace selected text without overwriting clipboard
vim.keymap.set("x", "<leader>lp", [["_dP]])

-- yank/paste into/from global register
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])


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


-- disable highlithing of search
-- vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true });

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- go faster to end and beginning of line
vim.keymap.set({"n", "o", "x"}, "<s-h>", "^", { desc = "Jump to beginning of line" })
vim.keymap.set({"n", "o", "x"}, "<s-l>", "g_", { desc = "Jump to end of line" })

-- Search for highlighted text in buffer
vim.keymap.set("v", "//", 'y/<C-R>"<CR>', { desc = "Search for highlighted text" })

-- safe file
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>aw", "<cmd>wa<CR>")
