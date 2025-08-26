return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
		    "neovim/nvim-lspconfig",
			"echasnovski/mini.icons",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- { "j-hui/fidget.nvim", opts = {} },
			"b0o/SchemaStore.nvim",
		},
		opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "jdtls", "gopls", "ty", "ruff", "cssls", "html", "jsonls", "ts_ls", "basedpyright", "ltex_plus" },
		},
	},
}
