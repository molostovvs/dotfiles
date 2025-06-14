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
        adapters = {
          require 'neotest-vstest' {
            dap_settings = {
              type = 'netcoredbg',
            },
          },
        },
        log_level = 5,
      }
    end,
  },
}
