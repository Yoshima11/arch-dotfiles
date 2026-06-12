-- /home/eduardo/dotfiles/nvim/lua/plugins/ia.lua

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  build = "make",
  opts = {
    provider = "lmstudio", -- Apunta al nombre del proveedor definido abajo
  
      -- Sintaxis actualizada: 'providers' en lugar de 'vendors'
      providers = {
        lmstudio = {
          __inherited_from = "openai",
          endpoint = "http://127.0.0.1:1234/v1",
          model = "qwen/qwen3.5-9b",
          api_key_name = "",
          timeout = 30000, -- Timeout de 30 segundos para conexión estable
        },
      },
  
      behaviour = {
        auto_suggestions = false, -- Modo legacy: sin sugerencias automáticas
        support_paste_from_clipboard = true, -- ⚠️ ACTIVADO para mejor productividad
      },
  
      context = {                      -- NUEVO: Contexto mejorado para respuestas precisas
        window_size = 50,             -- Líneas por ventana en el contexto
        max_context_tokens = 103763,    -- Tokens máximos de contexto
        file_context = true,          -- ⚠️ ACTIVADO: Mejora mucho las respuestas con contexto del archivo actual
        project_context = false,       -- Modo legacy: NO enviar todo el proyecto
      },
      prompt_template = "chatml",
      prompt = {                      -- NUEVO: Prompts personalizados
        system_prompt = "You are a helpful coding assistant specialized in code analysis and refactoring.",
        file_context_prompt = "Current file content:\n{file_content}",
      },
  },
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
