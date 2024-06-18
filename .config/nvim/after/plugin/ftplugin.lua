
-- vim.filetype.add({
--   extension = {
--     frag = 'vs', -- This line adds a custom filetype for the extension .asy
--   },
-- })


-------------------------------------------------------------------------------
--- ASYMPTOTE -----------------------------------------------------------------
-------------------------------------------------------------------------------

-- adds a custom filetype for .asy files, so asy.lua is executed when opening such file
vim.filetype.add({
  extension = {
    asy = 'asy', -- This line adds a custom filetype for the extension .asy
  },
})

-- setting syntax to cpp
local function set_asymptote_syntax()
    vim.cmd('set syntax=cpp')
end

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.asy',
    callback = set_asymptote_syntax
})


-------------------------------------------------------------------------------
--- TERRAFORM -----------------------------------------------------------------
-------------------------------------------------------------------------------

-- fix for terraform lsp working
vim.filetype.add({
    extensions = {
        tf = "terraform",
        tfvars = "terraform",
        tfstate = "json",
    },
})

-- fixing error in .tfvars files by setting filetype to terraform
local function set_terraform_filetype()
    vim.cmd('set filetype=terraform')
end

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.tfvars',
    callback = set_terraform_filetype
})

