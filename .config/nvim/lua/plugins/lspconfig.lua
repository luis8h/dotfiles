
-- Load LSP configuration
local lspconfig = require'lspconfig'


-------------------------------------------------------------------------------
--- LATEX ---------------------------------------------------------------------
-------------------------------------------------------------------------------

-- note: the following configuration is for ltexls which i do not use any more.
--       now i am using texlab

-- change language per markdown file? - add following 3 lines on top in file
--  ---
--  lang: de-DE
--  ---

-- disable ltexls by default
-- local ltexls_enabled = false
--
-- local function ltexls_setup()
--     require('lspconfig').ltex.setup({
--         on_attach = on_attach,
--         settings = {
--             ltex = {
--                 disabledRules = {
--                     -- ['en-US'] = { 'PROFANITY', 'MORFOLOGIK_RULE_EN_US', "UPPERCASE_SENTENCE_START", 'EN_A_VS_AN' }, -- disable spell checker by default
--                 },
--                 enabled = ltexls_enabled,
--             }
--         }
--     })
-- end
--
-- local function toggle_ltexls()
--     if ltexls_enabled then
--         ltexls_enabled = false
--     else
--         ltexls_enabled = true
--     end
--
--     ltexls_setup()
-- end
--
-- ltexls_setup()
-- vim.keymap.set("n", "<leader>ts", toggle_ltexls, { silent = true })









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
