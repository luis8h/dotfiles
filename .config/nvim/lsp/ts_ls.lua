return {
    -- Command to launch the TypeScript language server (adjust as needed)
    cmd = { "typescript-language-server", "--stdio" },
    -- Define filetypes this server should attach to
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    -- Define project root detection (you can use lspconfig's util.root_pattern)
    root_markers = { "package.json", "tsconfig.json", ".git" },
    -- Custom on_attach function for additional keybindings
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>co", function()
            vim.lsp.buf.execute_command({
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0), { skipDestructiveCodeActions = false } },
            })
        end, { buffer = bufnr, desc = "Organize Imports (TypeScript)" })
    end,
}
