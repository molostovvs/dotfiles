return {
  "bluz71/vim-nightfly-colors",
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme nightfly]])
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'white' })
  end,
}
