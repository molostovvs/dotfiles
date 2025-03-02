return {
  'epwalsh/obsidian.nvim',
  -- image pasting is broken in release version.
  -- version = '*',
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
