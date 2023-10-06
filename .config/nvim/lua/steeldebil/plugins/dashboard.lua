return {
  'glepnir/dashboard-nvim',
  enabled = true,
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      footer = {},
      packages = { enable = true },
      project = { enable = true, limit = 8, },
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
