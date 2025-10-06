return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'mfussenegger/nvim-dap-python',
      build = false, -- IMPORTANTE: Evitar instalación automática
    },
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    -- Configurar dap-python solo si está disponible
    local status_ok, _ = pcall(require, 'dap-python')
    if status_ok then
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    else
      -- Configuración manual como fallback
      dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' }
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = '~/.virtualenvs/debugpy/bin/python',
        },
      }
    end

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
