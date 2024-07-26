return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		config = function()
			-- vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			-- vim.cmd([[colorscheme rose-pine]])
		end,
	},
}


-- return {
--     "rose-pine/neovim",
--     config = function()
--
--         function ColorMyPencils(color)
--             color = color or "rose-pine"
--             vim.cmd.colorscheme(color)
--
--             vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--             vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--
--         end
--
--         ColorMyPencils()
--
--     end,
-- }



