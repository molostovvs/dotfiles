return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    enabled = true,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    keys = {
      { '<leader>fb', '<cmd>Oil<cr>', desc = '[F]ile [B]rowser' },
    },
  },
}
