return {
  {
    'pmizio/typescript-tools.nvim',
    enabled = false,
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  {
    'yioneko/nvim-vtsls',
    config = function()
      require('lspconfig.configs').vtsls = require('vtsls').lspconfig
    end,
  },
}
