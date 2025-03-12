return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
        sql = { 'sqlfluff' },
        lua = {
          'selene',
          'trivy',
        },
        cs = { 'trivy' },
        terraform = { 'tflint' },
        dockerfile = { 'hadolint' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        ghaction = { 'actionlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
