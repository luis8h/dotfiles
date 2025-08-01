return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        "nvim-telescope/telescope.nvim",
    },
    config = true,
    vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)
}
