return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mfussenegger/nvim-dap-python',
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Atajos para debugging
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue/Start debugging' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step into' })
    vim.keymap.set('n', '<leader>du', dap.step_out, { desc = 'Step out' })
  end
}
