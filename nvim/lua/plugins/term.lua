-- ~/.config/nvim/lua/plugins/term.lua
return {
  'akinsho/toggleterm.nvim',
  version = "*", 
  keys = {
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Flotante" },
    { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Terminal Horizontal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Terminal Vertical" },
  },
  opts = {
    -- Tecla principal para alternar (mapeo interno del plugin)
    open_mapping = [[<c-\>]], 
    insert_mappings = true, -- El atajo funciona en modo insertar
    terminal_mappings = true, -- El atajo funciona dentro de la terminal abierta
    direction = 'float',
  },
}
