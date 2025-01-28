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
}
