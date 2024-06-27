
return {
    'stevearc/oil.nvim',

    opts = {},

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        vim.keymap.set("n", "<leader>do", function()
            local home_dir = os.getenv("HOME")
            local downloads_dir = home_dir .. "/Downloads"
            require('oil').open(downloads_dir)
        end, { silent = true })

        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-p>"] = false,
                ["<C-r>"] = "actions.refresh",
            }
        })

    end,
}
