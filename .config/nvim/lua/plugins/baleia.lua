-- NOTE: This plugin is used by tmux when opening the history inside an nvim buffer to color the content
return {
    "m00qek/baleia.nvim",
    version = "*",
    submodules = false,
    config = function()
        vim.g.baleia = require("baleia").setup({
            -- 'terminal' usually yields a more accurate match for shell history
            colors = 'terminal',
            strip_ansi_codes = true,
        })
        vim.api.nvim_create_user_command("BaleiaColorize", function()
            vim.g.baleia.once(vim.api.nvim_get_current_buf())
        end, { bang = true })
    end
}
