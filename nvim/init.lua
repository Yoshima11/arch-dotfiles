-- ~/.config/nvim/init.lua
require("core.keymaps")
require("core.options")
require("lazy-setup")

-- Transparencia:
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
