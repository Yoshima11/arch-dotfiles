-- ~/.config/nvim/lua/plugins/format.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Ruff organiza imports y formatea
      python = { "ruff_organize_imports", "ruff_format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
