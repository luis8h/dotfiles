
return {
    "kylechui/nvim-surround",
    version = "*",
    config = function()

        require("nvim-surround").setup({
            -- remap S key to make flash.nvim work
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>Z",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yZ",
                normal_cur_line = "yZZ",
                visual = "Z",
                visual_line = "gZ",
                delete = "ds",
                change = "cs",
                change_line = "cZ",
            },
            aliases = {
                ["c"] = "```", -- could also be only for .md files
            },
        })
    end,
}
