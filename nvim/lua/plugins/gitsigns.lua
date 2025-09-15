return {
    "lewis6991/gitsigns.nvim", -- Integración de Git
    config = function()
        require("gitsigns").setup {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        }
    end,
}
