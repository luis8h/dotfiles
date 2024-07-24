return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        vim.keymap.set(
            "n",
            "<leader>tf",
            "<cmd>TodoTelescope keywords=TODO<cr>",
            { desc="telescope list todos (only TODO keyword)" }
        );
        vim.keymap.set(
            "n",
            "<leader>ta",
            "<cmd>TodoTelescope keywords=TODO,PERF,HACK,NOTE,FIX<cr>",
            { desc="telescope list todos (also other keywords)" }
        );
    }
}
