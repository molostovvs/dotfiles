local wk = require 'which-key'

local map = vim.keymap.set
map('n', ';', ':')

wk.add {
  { '<leader>c', group = '[C]ode' },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>tn', '<cmd>set relativenumber!<cr>', desc = '[T]oggle relative [N]umber lines' },
  { '<esc>', '<cmd>nohlsearch<cr>', mode = 'n' },
  { '[d', vim.diagnostic.goto_prev, desc = 'Previous [D]iagnostic message' },
  { ']d', vim.diagnostic.goto_next, desc = 'Next [D]iagnostic message ' },
  { '<leader>ce', vim.diagnostic.open_float, desc = 'Show [C]ode diagnostic [E]rror messages' },
  { '<leader>cq', vim.diagnostic.setloclist, desc = 'Open [C]ode diagnostic [Q]uickfix' },
  { '<C-h>', '<cmd>BufferPrevious<cr>', desc = 'Previous buffer' },
  { '<C-l>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
  { '<leader>x', '<cmd>BufferClose<cr>', desc = 'Close buffer' },
  {
    '<leader>ti',
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    desc = '[T]oggle [I]nlay hint',
  },
  {
    '<leader>tc',
    function()
      if vim.o.colorcolumn == '' then
        vim.o.colorcolumn = '80,100,120'
        vim.api.nvim_set_hl(0, 'ColorColumn', { bg = 'gray' })
      else
        vim.o.colorcolumn = ''
      end
    end,
    desc = '[T]oggle color [C]olumn',
    group = '[T]oggle',
  },
  {
    '<leader>cf',
    function()
      require('conform').format { async = true, lsp_fallback = true }
    end,
    desc = '[C]ode [F]ormat',
  },
  {
    '<leader>cp',
    function()
      require('actions-preview').code_actions()
    end,
    desc = '[C]ode actions [P]review',
    mode = { 'n', 'v' },
  },
}
