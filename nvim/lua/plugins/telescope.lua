-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    -- Configuración de apariencia
    telescope.setup({
      defaults = {
        -- Esta tabla define los caracteres de los bordes. 
        -- Los últimos 4 son las esquinas (arriba-izq, arriba-der, abajo-der, abajo-izq)
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      }
    })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Buscar archivos" }) -- Buscar archivos
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Buscar texto en el proyecto" })  -- Buscar texto en el proyecto
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Ver buffers abiertos" })    -- Ver buffers abiertos
  end
}
