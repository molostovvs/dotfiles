local servers = {
  docker_compose_language_service = {},
  docker_language_server = {},
  fsautocomplete = {},
  terraformls = {},
  bashls = {},
  jsonls = {},
  lua_ls = {},
  clangd = {},
  yamlls = {},
  marksman = {},
  tsgo = {},
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
    'neovim/nvim-lspconfig'
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    opts = {
      ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools),
    },
  },
}
