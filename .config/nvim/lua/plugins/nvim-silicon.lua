return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	main = "nvim-silicon",
	opts = {
		-- Configuration here, or leave empty to use defaults
        font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
        theme = 'Dracula',
        background = "#12121200",
        output = function()
            local home = os.getenv("HOME")
            local path = string.format(
                "%s/Pictures/code_%s.png",
                home,
                os.date("%Y-%m-%d_%H-%M-%S")
            )
            return path
        end,
        to_clipboard = true,
        pad_horiz = 0,
        pad_vert = 0,
        shadow_blur_radius = 0,
        shadow_offset_x = 0,
        shadow_offset_y = 0,
        shadow_color = nil,
        window_title = function()
            return vim.fn.fnamemodify(
                vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
                ":t"
            )
        end,
	}
}
