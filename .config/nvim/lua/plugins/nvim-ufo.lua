return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
        vim.o.foldcolumn = "0" -- use 1 for showing the fold level next to line numbers
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
        vim.keymap.set("n", "zK", function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, { desc = "Peek Fold" })

        vim.keymap.set("n", "zt", function()
            -- Get the current line number
            local line = vim.fn.line(".")
            -- Get the fold level of the current line
            local foldlevel = vim.fn.foldlevel(line)
            if foldlevel == 0 then
                vim.notify("No fold found", vim.log.levels.INFO)
            else
                vim.cmd("normal! za")
            end
        end, { desc = "Toggle fold" })

        require("ufo").setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { "lsp", "indent" }
            end,
        })
    end,
}
