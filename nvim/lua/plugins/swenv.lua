return {
  'AckslD/swenv.nvim',
  config = function()
    require('swenv').setup({
      get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
      end,
      venvs_path = vim.fn.expand('~/.venvs'),
  })

    vim.keymap.set('n', '<leader>se', function()
      require('swenv.api').pick_venv()
    end, { desc = 'Select Python env' })
    -- Aquí agregas el autocmd para reiniciar LSP
    vim.api.nvim_create_autocmd('User', {
      pattern = 'SwenvEnvChanged',
      callback = function()
        vim.cmd('LspRestart')  -- Reinicia el LSP para aplicar cambios
      end,
    })
  end
}
