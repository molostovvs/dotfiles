return {
  {
    'EdenEast/nightfox.nvim',
    enabled = false,
    lazy = false,
    -- priority = 1000,
    config = function()
      require('nightfox').setup {
        options = {
          styles = {
            comments = 'italic',
            constants = 'bold',
          },
        },
      }
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {
        options = {
          styles = {
            comments = 'italic',
          },
          transparent = true,
        },
      }
      vim.cmd.colorscheme 'github_dark_high_contrast'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        overrides = function()
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
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
}
