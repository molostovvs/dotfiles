return {
  'obsidian-nvim/obsidian.nvim',
  lazy = true,
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/source/notes/*.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/source/notes/*.md',
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    completion = {
      blink = true,
      nvim_cmp = false,
      min_chars = 2,
    },
    workspaces = {
      {
        name = 'personal',
        path = '~/source/notes/',
      },
    },
  },
}
