### lsp setup

##### add new lsp server
- to add an lsp server add it to the `ensure_installed` array in `./lua/plugins/mason.lua` or use `:Mason` to install it manually
- the plugins `mason-lspconfig` and `lsp-config` automatically enable the server with a default config
- to override this config create a file (named after the lsp server) in the `./lsp` directory

##### other configuration
- autocompletion is configured in `./lua/plugins/cmp.lua`
- all other lsp settings are located in `./lua/luis8h/lsp.lua`

##### java
- for java (jdtls) a separate plugin was added to unlock all capabilities
