-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--

vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>', { desc = '[T]oggle file [T]ree' })

-- options for ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- function for keymaps of nvim-tree
local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<left>', api.node.navigate.parent_close, opts 'Close directory')
  vim.keymap.set('n', '<right>', api.node.open.edit, opts 'Open directory')
end

return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    opts = {
      on_attach = my_on_attach,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      sort = { sorter = 'name', folders_first = true },
      view = { width = 30, side = 'right' },
      renderer = {
        group_empty = false,
        indent_markers = { enable = true },
        indent_width = 1,
        highlight_git = true,
        root_folder_label = true,
        icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
      },
      filters = { dotfiles = true },
      git = { enable = true, ignore = true },
    },
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      map_cr = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enable = true,
    max_lines = 10,
    min_window_height = 0,
    line_numbers = true,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      provider_select = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {},
  },
  {
    -- TODO: add keymaps because there is no deafult keymaps
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
  },
  {
    -- TODO: add keymaps and config
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
}
