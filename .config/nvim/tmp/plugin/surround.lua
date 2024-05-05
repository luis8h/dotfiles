
require("nvim-surround").setup({
    -- remap S key to make leap.nvim work
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>T",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yT",
        normal_cur_line = "yTT",
        visual = "T",
        visual_line = "gT",
        delete = "ds",
        change = "cs",
        change_line = "cT",
    },
    aliases = {
        ["c"] = "```", -- could also be only for .md files
    },
})


