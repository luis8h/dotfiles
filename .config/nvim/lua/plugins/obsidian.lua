return {
    "obsidian-nvim/obsidian.nvim", -- <- changed from epwalsh
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>od",  "<cmd>ObsidianToday<CR>",            desc = "Obsidian Today" },
        { "<leader>os",  "<cmd>ObsidianSearch<CR>",           desc = "Obsidian Search" },
        { "<leader>oo",  "<cmd>ObsidianQuickSwitch<CR>",      desc = "Obsidian Quick Switch" },
        { "<leader>on",  "<cmd>ObsidianNew<CR>",              desc = "Obsidian New Note" },
        { "gf",          "<cmd>ObsidianFollowLink<CR>",       desc = "Obsidian Follow Link" },
        { "<leader>oc",  "<cmd>ObsidianToggleCheckbox<CR>",   desc = "Obsidian Toggle Checkbox" },
        { "<leader>otd", "<cmd>ObsidianTemplate default<CR>", desc = "Obsidian insert default template" },
        { "<leader>ot",  "<cmd>ObsidianTemplate<CR>",         desc = "Obsidian insert" },
    },
    opts = {
        completion = {
            blink = true,
            min_chars = 2,
        },
        daily_notes = {
            folder = "daily",
            template = "default-daily"
        },
        disable_frontmatter = true,
        workspaces = {
            {
                name = "kbase",
                path = vim.fn.expand(vim.env.H8_KBASE_DIR),
            },
        },
        templates = {
            folder = vim.fn.expand(vim.env.H8_KBASE_DIR .. "/templates"),
        },
    },
}
