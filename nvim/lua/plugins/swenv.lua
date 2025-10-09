return {
  'AckslD/swenv.nvim',
  config = function()
    require('swenv').setup({
      get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
      end,
      venvs_path = vim.fn.expand('~/.virtualenvs/'),
      
      post_set_venv = function()
        vim.notify(string.format("Python env changed to: %s", vim.env.VIRTUAL_ENV or "system"))
      end,
  })

    vim.keymap.set('n', '<leader>se', function()
      require('swenv.api').pick_venv()
    end, { desc = 'Select Python env' })
    
    vim.keymap.set('n', '<leader>sc', function()
      require('swenv.api').get_current_venv()
    end, { desc = 'Show current Python env' })
    
    -- Aquí agregas el autocmd para reiniciar LSP
    vim.api.nvim_create_autocmd('User', {
      pattern = 'SwenvEnvChanged',
      callback = function()
        vim.defer_fn(function()
          vim.cmd('LspRestart')  -- Reinicia el LSP para aplicar cambios
          vim.notify("LSP restartedd with new python environment", vim.log.levels.INFO)
        end, 100)
      end,
    })
  end
}
