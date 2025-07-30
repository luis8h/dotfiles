return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		cmd = { "Mason" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
		    "neovim/nvim-lspconfig",
			"echasnovski/mini.icons",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- { "j-hui/fidget.nvim", opts = {} },
			"b0o/SchemaStore.nvim",
			"rrethy/vim-illuminate",
		},
		opts = {
            ensure_installed = { "lua_ls", "rust_analyzer", "jdtls", "gopls", "ty", "ruff", "cssls", "html", "jsonls", "ts_ls" },
		},
		config = function(_, opts)
			----------------------------------
			-- Server configuration
			----------------------------------
			-- Get server names from after/lsp
			-- local servers = {}
			-- local lsp_servers_path = vim.fn.stdpath("config") .. "/lsp"
			--
			-- for file in vim.fs.dir(lsp_servers_path) do
			-- 	local name = file:match("(.+)%.lua$")
			-- 	if name then
			-- 		servers[name] = true
			-- 	end
			-- end
			----------------------------------
			-- Add servers automaticlly
			----------------------------------
			-- local ensure_installed = vim.tbl_keys(servers or {})
			-- vim.list_extend(ensure_installed, opts.lsp_servers)
			-- vim.list_extend(ensure_installed, opts.tools)
			--
			-- require("mason-lspconfig").setup({
			-- 	ensure_installed = {},
			-- })
			--
			-- require("mason-tool-installer").setup({
			-- 	ensure_installed = ensure_installed,
			-- 	auto_update = true,
			-- 	run_on_start = true,
			-- })
		end,
	},
}
