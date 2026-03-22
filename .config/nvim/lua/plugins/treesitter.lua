return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')

        ts.install(
            {
                -- 1. Structural & Config (Essential for Markdown frontmatter & CLI)
                'yaml', 'json', 'toml', 'ron', 'xml', 'csv', 'ini', 'dockerfile',

                -- 2. Scripting & Systems (The "Must-Haves")
                'bash', 'fish', 'zsh', 'rust', 'python', 'lua', 'zig', 'go', 'gomod', 'c', 'cpp',

                -- 3. Web & App Development
                'javascript', 'typescript', 'tsx', 'html', 'css', 'scss', 'java', 'kotlin', 'ruby',

                -- 4. Documentation & Git (The "Invisible" Essentials)
                'markdown', 'markdown_inline', 'vim', 'vimdoc', 'query', 'diff', 'git_config', 'gitcommit', 'gitignore'
            }
        )
    end
}
