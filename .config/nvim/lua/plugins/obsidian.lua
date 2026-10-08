return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>od",  "<cmd>Obsidian today<CR>",            desc = "Obsidian Today" },
        { "<leader>os",  "<cmd>Obsidian search<CR>",           desc = "Obsidian Search" },
        { "<leader>oo",  "<cmd>Obsidian quick_switch<CR>",     desc = "Obsidian Quick Switch" },
        { "<leader>on",  "<cmd>Obsidian new<CR>",              desc = "Obsidian New Note" },
        { "gf",          "<cmd>Obsidian follow_link<CR>",      desc = "Obsidian Follow Link" },
        { "<leader>oc",  "<cmd>Obsidian toggle_checkbox<CR>",  desc = "Obsidian Toggle Checkbox" },
        { "<leader>otd", "<cmd>Obsidian template default<CR>", desc = "Obsidian insert default template" },
        { "<leader>ot",  "<cmd>Obsidian template<CR>",         desc = "Obsidian insert" },
        { "<leader>op",  "<cmd>Obsidian paste_img<CR>",        desc = "Obsidian Paste Image" },
    },
    opts = {
        legacy_commands = false,
        frontmatter = {
            enabled = false,
        },
        daily_notes = {
            folder = "daily",
            template = "default-daily",
        },
        workspaces = {
            {
                name = "kbase",
                path = vim.fn.expand(vim.env.H8_KBASE_DIR),
            },
        },
        templates = {
            folder = vim.fn.expand(vim.env.H8_KBASE_DIR .. "/templates"),
        },
        attachments = {
            folder = "assets", -- relative to the vault root
            -- img_text_func = function(path)
            --     -- Obsidian-style embed: ![[image.png]]
            --     return string.format("![[%s]]", path.name)
            -- end,
        },
    },
}
