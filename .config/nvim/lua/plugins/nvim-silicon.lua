return {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
        require("silicon").setup({
            -- Configuration here, or leave empty to use defaults
            font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
            output = function ()
                return '/' .. os.getenv("HOME") .. "/Pictures/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
            end,
            theme = 'Dracula',
            window_title = function()
                return vim.fn.fnamemodify(
                vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
                ":t"
                )
            end,
        })
    end
}

