
return {
    "laytan/cloak.nvim",
    config = function()

        require("cloak").setup({
            enabled = true,
            cloak_character = "*",
            -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
            highlight_group = "Comment",
            patterns = {
                {
                    -- Match any file starting with ".env".
                    -- This can be a table to match multiple file patterns.
                    file_pattern = {
                        ".env*",
                        "wrangler.toml",
                        ".dev.vars",
                    },
                    -- Match an equals sign and any character after it.
                    -- This can also be a table of patterns to cloak,
                    -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
                    cloak_pattern = "=.+"
                },
            },
        })

        -- toggle all
        vim.keymap.set("n", "<leader>cta", function()
            vim.cmd("CloakToggle")
        end)

        -- show one line
        vim.keymap.set("n", "<leader>cl", function()
            vim.cmd("CloakPreviewLine")
        end)

    end,
}
