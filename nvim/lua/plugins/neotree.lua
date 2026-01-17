-- ~/.config/nvim/lua/plugins/neotree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Iconos bonitos
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = 25,
      }
    })
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {}) -- Espacio + e para abrir/cerrar
  end
}
