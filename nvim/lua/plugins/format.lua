-- ~/.config/nvim/lua/plugins/format.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Ruff organiza imports y formatea
      python = { "ruff_organize_imports", "ruff_format" }, 

      -- Web: Prettier es el estándar para casi todo lo visual
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },

      -- Lua: Stylua es el que usa la comunidad de Neovim
      lua = { "stylua" },
      
      -- El símbolo "*" aplica a cualquier lenguaje que no esté en la lista
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
