local wk = require 'which-key'

-- map('n', 'C-p', function()
--   require('hover').hover_switch 'previous'
-- end, { desc = 'hover previous' })
--
-- map('n', 'C-n', function()
--   require('hover').hover_switch 'next'
-- end, { desc = 'hover next' })

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
  { ';', ':', desc = 'Command mode with semicolon' },
  { '<C-h>', '<cmd>BufferPrevious<cr>', desc = 'Previous buffer' },
  { '<C-l>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
  { '<leader>x', '<cmd>BufferClose<cr>', desc = 'Close buffer' },
  {
    'gK',
    function()
      require('hover').hover_select()
    end,
    desc = 'Hover select',
  },
  {
    '<leader>ll',
    function()
      vim.diagnostic.config {
        virtual_text = not vim.diagnostic.config()['virtual_text'],
        virtual_lines = not vim.diagnostic.config()['virtual_lines'],
      }
    end,
    desc = 'Toggle [L]sp [L]ines',
  },
  {
    'K',
    function()
      require('hover').hover()
    end,
    desc = 'Hover',
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
