return {
  {
    'ray-x/lsp_signature.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      floating_window = false,
      bind = true,
      max_height = 20,
      max_width = 120,
      wrap = true,
      hint_enable = true,
      hint_prefix = {
        above = '↙ ',
        current = '← ',
        below = '↖ ',
      },
      handler_opts = {
        border = 'rounded',
      },
      padding = '',
    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
}
