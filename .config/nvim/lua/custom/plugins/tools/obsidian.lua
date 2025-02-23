return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/source/notes/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/source/notes/*.md',
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/source/notes/',
      },
    },
  },
}
