-- ~/.config/nvim/lua/plugins/venv.lua
return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { 
    "neovim/nvim-lspconfig", 
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python" -- Opcional: para depuración
  },
  -- branch = "regexp", -- Recomendado para mayor compatibilidad
  config = function()
    require("venv-selector").setup({
      -- Directorio donde guardas tus entornos
      settings = {
        search = {
          my_venvs = {
            command = "fd /bin/python$ ~/.virtualenvs --full-path --color never"
          },
        },
      },
    })
    -- Atajo para abrir el selector
    vim.keymap.set('n', '<leader>vs', '<cmd>VenvSelect<cr>')
  end,
}
