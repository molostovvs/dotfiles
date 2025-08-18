return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = true,
      notify_no_formatters = true,
      format_on_save = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        fsharp = { 'fantomas' },
        markdown = { 'markdownlint' },
        sh = { 'shfmt' },
        json = { 'jq' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        c = { 'clang-format' },
        yaml = { 'yamlfmt' },
      },
      formatters = {
        injected = {
          options = {
            ignore_errors = false,
            lang_to_ext = {
              json = 'json',
              bash = 'sh',
              c_sharp = 'cs',
              markdown = 'md',
              typescript = 'ts',
              sql = 'sql',
            },
          },
        },
      },
    },
  },
}
