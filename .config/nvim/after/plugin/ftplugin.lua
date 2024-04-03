
-- adds a custom filetype for .asy files, so asy.lua is executed when opening such file
vim.filetype.add({
  extension = {
    asy = 'asy', -- This line adds a custom filetype for the extension .asy
  },
})
