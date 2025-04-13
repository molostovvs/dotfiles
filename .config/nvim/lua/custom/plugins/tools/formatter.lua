return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = true,
      notify_no_formatters = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 1000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        fsharp = { 'fantomas' },
        markdown = { 'markdownlint' },
        sh = { 'shfmt' },
        json = { 'jq' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        c = { 'clang-format' },
      },
      formatters = {
        injected = {
          options = {
            ignore_errors = false,
            -- map of treesitter language to file extension
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
