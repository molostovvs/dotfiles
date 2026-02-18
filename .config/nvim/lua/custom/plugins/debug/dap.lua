return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#993939' })

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '󱞆', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = 'Debug: See last session result.' })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<leader>dr', dap.run_to_cursor, { desc = 'Debug: Run to cursor' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>du', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dl', function()
        dap.set_breakpoint(nil, nil, vim.fn.input 'Log message')
      end, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '',
            terminate = '',
            disconnect = '',
          },
        },
      }

      dap.configurations.cs = {
        stopOnEntry = false,
        justMyCode = true,
      }

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
