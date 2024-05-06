
return {
    "rose-pine/neovim",
    config = function()

        color = color or "rose-pine"
        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    end,
}



-- old config

-- require('rose-pine').setup({
--     disable_background = true
-- })
--
-- function ColorMyPencils(color)
        -- color = color or "rose-pine"
        -- vim.cmd.colorscheme(color)
        --
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--
-- end
--
-- ColorMyPencils()
