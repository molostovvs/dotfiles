local tools = {
  'docker-compose-language-service',
  'docker-language-server',
  'fsautocomplete',
  'terraform-ls',
  'bash-language-server',
  'json-lsp',
  'lua-language-server',
  'clangd',
  'yaml-language-server',
  'marksman',
  'tsgo',
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
  'kube-linter',
  'tombi',
  'postgres-language-server',
}

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ui = { border = 'rounded' },
      registries = {
        'github:mason-org/mason-registry',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = tools,
    },
  },
}
