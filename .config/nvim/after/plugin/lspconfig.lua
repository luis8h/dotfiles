
-- Load LSP configuration
local lspconfig = require'lspconfig'


-------------------------------------------------------------------------------
--- LATEX ---------------------------------------------------------------------
-------------------------------------------------------------------------------

-- change language per markdown file? - add following 3 lines on top in file
--  ---
--  lang: de-DE
--  ---

-- Define language specific configurations
local ltex_language_settings = {
    on_attach = on_attach,
    settings = {
        ltex = {
            language = "en-US",
            disabledRules = {
                ['en-US'] = { 'PROFANITY', 'MORFOLOGIK_RULE_EN_US' } -- disable spell checker by default
            }
        }
    }
}
lspconfig.ltex.setup(ltex_language_settings)






-- example how a configuration could look like, but defaults of pyiright are good for now

-- local function on_attach(client, bufnr)
--     print('attaching')
-- end
-- local lspconfig = require('lspconfig')
-- lspconfig.pyright.setup {
--     on_attach = on_attach,
--     settings = {
--         pyright = {autoImportCompletion = true,},
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 maxLineLength = nil,
--                 ignore = {
--                     "no-docstring-on-blank-line",
--                     "trailing-whitespace"
--                 }
--             }
--         }
--     }
-- }
