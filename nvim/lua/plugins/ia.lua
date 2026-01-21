return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  opts = {
    provider = "ollama",
    auto_suggestions_provider = "ollama",
    providers = {
      ollama = {
        ["local"] = true,
        endpoint = "http://127.0.0.1:11434",
        model = "deepseek-coder-v2:16b",
        parameters = {
          temperature = 0.3,
          top_p = 0.9,
          top_k = 40,
          repeat_penalty = 1.1,
          num_predict = 8192,
        },
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
  },
}
