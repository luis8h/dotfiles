-- https://github.com/norcalli/nvim-colorizer.lua
-- This plugin allows me to see the colors of hex code inside files

return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
        vim.keymap.set("n", "<leader>cs", "<cmd>ColorizerToggle<cr>", { desc = "toggle colorizer" });
    end,
}
