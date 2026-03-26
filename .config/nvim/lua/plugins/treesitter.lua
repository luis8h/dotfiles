return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')
        ts.install({
            -- Structural & Config
            'yaml', 'json', 'toml', 'ron', 'xml', 'csv', 'ini', 'dockerfile',
            -- Scripting & Systems
            'bash', 'fish', 'zsh', 'rust', 'python', 'lua', 'zig', 'go', 'gomod', 'c', 'cpp',
            -- Web & App
            'javascript', 'typescript', 'tsx', 'html', 'css', 'scss', 'java', 'kotlin', 'ruby',
            -- Docs & Git
            'markdown', 'markdown_inline', 'vim', 'vimdoc', 'query', 'diff',
            'git_config', 'gitcommit', 'gitignore',
        })

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
