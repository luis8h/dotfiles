-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.smartcase = true

-- line wrapping
-- vim.opt.wrap = true
vim.opt.wrap = true
vim.opt.breakindent = true
-- vim.opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.opt.linebreak = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- vim.opt.scrolloff = 8
vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.g.netrw_bufsettings = "noma nomod nu rnu"

-- enable autoread, so changes of other programs on a file will be applied automaticly
vim.opt.autoread = true

-- enable highlighting of cursorline
vim.o.cursorline = true
-- Customize the appearance of the cursor line
-- vim.cmd [[
-- highlight CursorLine cterm=NONE ctermbg=darkgrey guibg=lightgrey
-- ]]
