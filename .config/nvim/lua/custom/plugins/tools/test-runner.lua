return {
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nsidorenco/neotest-vstest',
    },
    version = '*',
    config = function()
      require('neotest').setup {
        summary = {
          count = true,
          follow = true,
          open = function()
            local current_win = vim.api.nvim_get_current_win()
            local current_height = vim.api.nvim_win_get_height(current_win)
            local target_height = math.max(math.floor(current_height * 0.4), 3)

            local summary_win = vim.api.nvim_open_win(0, true, {
              split = 'below',
              win = current_win,
              height = target_height,
            })

            return summary_win
          end,
        },
        diagnostic = {
          enabled = true,
          severity = vim.diagnostic.severity.ERROR,
        },
        status = {
          virtual_text = true,
          signs = false,
          enabled = true,
        },
        state = {
          enabled = true,
        },
        running = {
          concurrent = true,
        },
        discovery = {
          concurrent = 64,
          enabled = true,
        },
        adapters = {
          require 'neotest-vstest' {
            dap_settings = {
              type = 'coreclr',
            },
          },
        },
        log_level = vim.log.levels.OFF,
      }
    end,
    keys = {
      {
        '<leader>ws',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Tests Summary',
      },
      {
        '<leader>wr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run test under cursor',
      },
      {
        '<leader>wd',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug test under cursor',
      },
      {
        '<leader>wo',
        function()
          require('neotest').output.open { enter = false }
        end,
        desc = 'Test open output window',
      },
      {
        '<leader>wpt',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Test toggle output panel',
      },
      {
        '<leader>wpc',
        function()
          require('neotest').output_panel.clear()
        end,
        desc = 'Test clear output panel',
      },
    },
  },
}
