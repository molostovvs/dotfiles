return {
  {
    'yioneko/nvim-vtsls',
    config = function()
      require('lspconfig.configs').vtsls = require('vtsls').lspconfig
    end,
  },
}
