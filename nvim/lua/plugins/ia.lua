--- ~/.config/nvim/lua/plugins/ai.lua
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- IMPORTANTE: Nunca lo pongas como "*"
  opts = {
    provider = "openai", -- 1. Usamos el provider 'openai' genérico
    providers = {
      openai = {        -- 2. Configuramos 'openai' para que apunte a LM Studio
        endpoint = "http://127.0.0.1:1234/v1",
        model = "qwen/qwen3.5-9b-uncensored-hauhaucs-aggressive", -- El nombre exacto de tu modelo en LM Studio
        api_key_name = "", -- No necesita API key
        timeout = 30000,
        extra_request_body = {
          temperature = 0.7,
          max_tokens = 8192,
        },
      },
    },
    behaviour = {
      auto_suggestions = false, -- Recomendado desactivarlo para modelos locales
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
    },
  },
  
  keys = {
    { "<leader>aa", function() require("avante.api").ask() end, desc = "AI Ask (chat)", mode = { "n", "v" } },
    { "<leader>ae", function() require("avante.api").edit() end, desc = "AI Edit file", mode = { "v" } },
    { "<leader>af", function() require("avante.api").file_ask() end, desc = "AI Ask about file", mode = { "n" } },
  },
  
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}
