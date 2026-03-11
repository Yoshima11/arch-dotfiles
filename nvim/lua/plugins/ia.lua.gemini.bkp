-- ~/.config/nvim/lua/plugins/avante.lua
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, 
  opts = {
    provider = "gemini", -- Esto indica qué proveedor usar por defecto
    
    -- AQUÍ ES DONDE DEBE IR AHORA
    providers = {
      gemini = {
        model = "gemini-2.5-flash",
        max_tokens = 4096,
        temperature = 0,
        -- Si prefieres usar Gemini 1.5 Pro, simplemente cambia el modelo arriba
      },
    },

    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
    },
  },
  
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "HakonHarnes/img-clip.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
  build = "make", 
}
