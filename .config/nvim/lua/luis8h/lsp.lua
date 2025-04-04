vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf, remap = false }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
        vim.keymap.set("n", "<leader>vff", function() vim.lsp.buf.format({ async = true }) end)
        vim.keymap.set("v", "<leader>vfr", function()
            vim.lsp.buf.format({
                async = true,
                range = {
                    ['start'] = vim.api.nvim_buf_get_mark(0, "<"),
                    ['end'] = vim.api.nvim_buf_get_mark(0, ">"),
                }
            })
        end)
        vim.keymap.set("n", "<leader>co", function()
            vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" } },
                apply = true, -- auto apply if there's a single action
            })
        end, { desc = "Auto-import missing dependencies" })
    end,
})
