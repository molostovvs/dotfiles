return {
  'obsidian-nvim/obsidian.nvim',
  lazy = true,
  version = "*",
  ft = "markdown",
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'personal',
        path = '~/source/notes',
      },
    },
  },
}
