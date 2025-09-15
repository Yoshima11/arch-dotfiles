return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/neotest-python',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-python')({
          dap = { justMyCode = false },
          runner = 'pytest',
          python = '.venv/bin/python',
        })
      }
    })

    -- Atajos para testing
    vim.keymap.set('n', '<leader>tt', function()
      require('neotest').run.run()
    end, { desc = 'Run test' })
    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand('%'))
    end, { desc = 'Run test file' })
    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').summary.toggle()
    end, { desc = 'Toggle test summary' })
  end
}
