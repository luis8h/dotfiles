return {
    'nvim-mini/mini.ai',
    version = '*',
    config = function()
        require('mini.ai').setup({
            custom_textobjects = {
                -- Enables vi* and va* for Markdown bold (**text**)
                ['*'] = { '%*%*().-()%*%*' },
            }
        })
    end,
}
