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

        -- IMPORTANT: In the 'main' branch of nvim-treesitter, you must manually trigger the highlighter.
        -- This autocmd will start Tree-sitter highlighting whenever you open a supported file.
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf = args.buf
                local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)

                -- 1. Check if Neovim even knows this language
                -- 2. Check if the parser is actually installed on your system
                if lang and pcall(vim.treesitter.get_parser, buf, lang) then
                    vim.treesitter.start(buf, lang)
                end
            end,
        })
    end
}
