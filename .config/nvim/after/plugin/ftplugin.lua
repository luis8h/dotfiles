
-------------------------------------------------------------------------------
--- ASYMPTOTE -----------------------------------------------------------------
-------------------------------------------------------------------------------
--adds a custom filetype for .asy files, so asy.lua is executed when opening such file
vim.filetype.add({
  extension = {
    asy = 'asy', -- This line adds a custom filetype for the extension .asy
  },
})


-------------------------------------------------------------------------------
--- TERRAFORM -----------------------------------------------------------------
-------------------------------------------------------------------------------

-- Define function to set Terraform filetype
_G.set_terraform_filetype = function ()
    vim.bo.filetype = "terraform"
end
-- workaround for .tfvars file to work without error by setting the filetype to terraform automaticly
vim.cmd([[
  augroup TerraformFileType
    autocmd!
    autocmd BufNewFile,BufRead *.tf setfiletype terraform
    autocmd BufNewFile,BufRead *.tfvars lua set_terraform_filetype()
    autocmd BufNewFile,BufRead *.tfstate setfiletype json
  augroup END
]])

-- fix for terraform lsp working
vim.filetype.add({
    extensions = {
        tf = "terraform",
        tfvars = "terraform",
        tfstate = "json",
    },
})
