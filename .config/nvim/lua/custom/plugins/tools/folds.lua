return {
  {
    'kevinhwang91/nvim-ufo',
    enabled = true,
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      provider_selector = function(_, _, _)
        return { 'lsp', 'indent' }
      end,
      close_fold_kinds_for_ft = {
        default = {
          -- 'implementation', it is very badly implemented.
          'imports',
          'comment',
          'region',
        },
      },
      enable_get_fold_virt_text = {
        default = true,
      },
    },
  },
}
