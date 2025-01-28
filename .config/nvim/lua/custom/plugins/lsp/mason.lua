return {
  {
    'williamboman/mason.nvim',
    opts = {
      ui = { border = 'rounded' },
      registries = {
        'github:mason-org/mason-registry',
        'github:crashdummyy/mason-registry',
      },
    },
  },
  'williamboman/mason-lspconfig.nvim',
  'WhoIsSethDaniel/mason-tool-installer.nvim',
}
