local augroup = vim.api.nvim_create_augroup
local luis8h_group = augroup('luis8h', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- shortly highlights text when yanking
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- removes trailing whitespaces on save
-- use `:noa w` to save without using this
autocmd({ "BufWritePre" }, {
    group = luis8h_group,
    pattern = "*",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})


-- fix python command indenting not working
vim.api.nvim_create_augroup("PythonIndentFix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "PythonIndentFix",
    pattern = "python",
    callback = function()
        vim.opt_local.smartindent = false
    end,
})
