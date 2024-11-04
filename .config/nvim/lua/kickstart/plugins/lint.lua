return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['markdown'] = { 'markdownlint' }
      lint.linters_by_ft['json'] = { 'jsonlint' }
      lint.linters_by_ft['sql'] = { 'sqlfluff' }
      lint.linters_by_ft['lua'] = { 'luacheck' }
      lint.linters_by_ft['terraform'] = { 'tflint' }
      lint.linters_by_ft['dockerfile'] = { 'hadolint' }
      lint.linters_by_ft['typescript'] = { 'eslint_d' }
      lint.linters_by_ft['typescriptreact'] = { 'eslint_d' }

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
