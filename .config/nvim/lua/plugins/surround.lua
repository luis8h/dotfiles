
return {
    "kylechui/nvim-surround",
    version = "*",
    config = function()

        require("nvim-surround").setup({
            -- remap S key to make flash.nvim work
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_cur_line = "ySS",
                visual = "S",
                visual_line = "gS",
                delete = "ds",
                change = "cs",
                change_line = "cS",
            },
            aliases = {
                ["c"] = "```", -- could also be only for .md files
            },
        })
    end,
}
