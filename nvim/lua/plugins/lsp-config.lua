-- ~/.config/nvim/lua/lsp-config.lua
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Configuración base
      local lspconfig = require('lspconfig')
      local mason = require('mason')
      local mason_lsp = require('mason-lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      require("lspconfig").clangd.setup {
        on_attach = on_attach,
        capabilities = cmp_nvim_lsp.default_capabilities(),
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      }

      mason.setup()
      -- mason_lsp.setup({
      --   ensure_installed = {'ruff', 'pyright'},  -- Nota: 'ruff' en lugar de 'ruff_lsp'
      --   automatic_installation = true,
      -- })
      lspconfig.ruff.setup({
          capabilities = capabilities,
          init_options = {
              settings = {
                  lineLength = 120,
                  lint = { select = {"E", "F", "I"} }
              }
           }
      })

      lspconfig.pyright.setup({
          capabilities = capabilities,
          settings = {
              python = {
                  analysis = {
                      typeCheckingMode = "basic",
                      diagnosticSeverityOverrides = {
                          reportUnusedVariable = "warning",
                          reportMissingImports = "none"
                      }
                  }
              }
          }
      })

      local lsp = vim.lsp.buf
      local opts = { noremap = true, silent = true }

      -- Atajos generales
      vim.keymap.set('n', 'gd', lsp.definition, { desc = 'Go to definition' })
      vim.keymap.set('n', 'K', lsp.hover, { desc = 'Show documentation' })
      vim.keymap.set('n', '<leader>lf', lsp.format, { desc = 'Format code' })
      vim.keymap.set('n', '<leader>la', lsp.code_action, { desc = 'Code actions' })
      vim.keymap.set('n', '<leader>lr', lsp.rename, { desc = 'Rename symbol' })
      vim.keymap.set('n', 'gr', lsp.references, { desc = 'Show references' })

      -- Atajos para diagnósticos
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
      vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Show diagnostic' })

      -- Atajo para mostrar todos los keymaps disponibles
      vim.keymap.set('n', '<leader>l', function()
        vim.cmd('WhichKey <leader>l')
      end, { desc = 'Show LSP keymaps' })
    end
  }
}
