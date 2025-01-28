return {
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'Issafalcon/neotest-dotnet',
    },
    version = '*',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-dotnet' {
            discovery_root = 'solution',
          },
        },
        log_level = 5,
      }
    end,
  },
}
