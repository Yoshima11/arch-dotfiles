return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters = {
        black = {
          prepend_args = { "--line-length=120" }
        },
        isort = {
          prepend_args = { "--profile=black", "--line-length=120" }
        }
      }
    },
  }
}
