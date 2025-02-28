local servers = {
  docker_compose_language_service = {},
  roslyn = {},
  fsautocomplete = {},
  terraformls = {},
  bashls = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Both',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        hint = {
          enable = true,
        },
      },
    },
  },
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
  'luacheck',
  'selene',
  'tflint',
  'actionlint',
  'shfmt',
  'fantomas',
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
    opts = {
      ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools),
    },
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
}
