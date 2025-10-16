local servers = {
  docker_compose_language_service = {},
  fsautocomplete = {},
  terraformls = {},
  bashls = {},
  jsonls = {},
  lua_ls = {},
  clangd = {},
  yamlls = {},
  marksman = {},
  rust_analyzer = {},
}

local tools = {
  'stylua',
  'jq',
  'prettier',
  'eslint_d',
  'sqlfmt',
  'jsonlint',
  'markdownlint',
  'netcoredbg',
  'hadolint',
  'selene',
  'tflint',
  'actionlint',
  'shfmt',
  'fantomas',
  'clang-format',
  'yamlfmt',
}

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
  {
    'williamboman/mason-lspconfig',
    event = 'VeryLazy',
    dependencies = { 'saghen/blink.cmp', 'neovim/nvim-lspconfig' },
    opts = {
      handlers = {
        function(server_name)
          local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)
          capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          }
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    opts = {
      ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools),
    },
  },
}
