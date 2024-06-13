
return {
    'stevearc/oil.nvim',

    opts = {},

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()

        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-p>"] = false,
                ["<C-r>"] = "actions.refresh",
            }
        })

    end,
}
