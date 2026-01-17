-- ~/.config/nvim/lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Aquí puedes personalizar el retraso o el diseño
    delay = 300, -- Tiempo en milisegundos para que aparezca el menú
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    -- Opcional: Registrar etiquetas para que los grupos se vean mejor
    wk.add({
      { "<leader>f", group = "Archivos (Telescope)" },
      { "<leader>v", group = "Entorno Virtual (Venv)" },
      { "<leader>c", group = "Código / LSP" },
    })
  end,
}
