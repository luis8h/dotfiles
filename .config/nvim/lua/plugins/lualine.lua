return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = '|',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1, -- 0: Just the filename, 1: Relative path, 2: Absolute path
                    },
                },
            },
        },
    }
}
