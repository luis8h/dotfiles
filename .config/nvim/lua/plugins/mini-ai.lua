return {
    'nvim-mini/mini.ai',
    version = '*',
    config = function()
        require('mini.ai').setup({
            n_lines = 500,
            custom_textobjects = {
                ['*'] = { '%*().-()%*' },
                t = false,
            },
        })
    end,
}
