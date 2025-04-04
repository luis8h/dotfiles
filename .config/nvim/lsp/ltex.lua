return {
    cmd = { "ltex-ls" },                    -- adjust this if your ltex server command is different
    filetypes = { "tex", "bib", "markdown" }, -- set as needed for your use-case
    root_markers = { ".git" },              -- or use a function like vim.lsp.util.root_pattern(...)
    settings = {
        ltex = {
            language = "en",
            additionalRules = {
                languageModel = "~/models/ngrams/",
            },
        },
    },
}
