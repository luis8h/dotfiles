return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls", "rust_analyzer", "jdtls", "gopls", "ty", "ruff", "cssls", "html", "jsonls", "ts_ls" },
        -- prettier, prettierd
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
