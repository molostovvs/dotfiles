return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        overrides = function()
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
            Visual = { bg = '#444444' },
          }
        end,
        theme = 'wave',
        transparent = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
      }
      vim.cmd 'colorscheme kanagawa-wave'
    end,
  },
  {
    'lunarvim/templeos.nvim',
  },
  {
    'luisiacc/gruvbox-baby',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_baby_transparent_mode = true
      vim.cmd 'colorscheme gruvbox-baby'
    end,
  },
}
