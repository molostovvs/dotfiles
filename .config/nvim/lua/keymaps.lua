local wk = require 'which-key'

local map = vim.keymap.set
map('n', ';', ':')

local minuet_actions = require('minuet.virtualtext').action

local get_max_width = function()
  return math.floor(vim.fn.winwidth(0) / 1.3)
end

map('n', 'K', function()
  vim.lsp.buf.hover {
    border = 'rounded',
    title = 'docs',
    max_width = get_max_width(),
    wrap = true,
  }
end, { desc = 'Hover' })

wk.add {
  { '<leader>c', group = '[C]ode' },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>b', group = '[B]uffer' },
  { '<leader>tn', '<cmd>set relativenumber!<cr>', desc = '[T]oggle relative [N]umber lines' },
  {
    '<leader>td',
    function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end,
    desc = '[T]oggle [D]iagnostic',
  },
  {
    '<A-f>',
    function()
      require('lsp_signature').toggle_float_win()
    end,
    mode = { 'i' },
    desc = '[F]loat LSP signature',
  },
  { '<esc>', '<cmd>nohlsearch<cr>', mode = 'n' },
  {
    '[d',
    function()
      vim.diagnostic.jump {
        count = -1,
        float = {
          border = 'rounded',
          max_width = get_max_width(),
          title = 'diag',
        },
      }
    end,
    desc = 'Previous [D]iagnostic message',
  },
  {
    ']d',
    function()
      vim.diagnostic.jump {
        count = 1,
        float = {
          border = 'rounded',
          max_width = get_max_width(),
          title = 'diag',
        },
      }
    end,
    desc = 'Next [D]iagnostic message ',
  },
  {
    '<leader>ce',
    function()
      vim.diagnostic.open_float { border = 'rounded', max_width = get_max_width(), title = 'my-title' }
    end,
    desc = 'Show [C]ode diagnostic [E]rror messages',
  },
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
  { '<leader>bp', '<Cmd>BufferMovePrevious<CR>', mode = { 'n' }, desc = '[B]uffer [P]revious' },
  { '<leader>bn', '<Cmd>BufferMoveNext<CR>', mode = { 'n' }, desc = '[B]uffer [N]ext' },
  { '<leader>bb', '<Cmd>BufferPin<CR>', mode = { 'n' }, desc = '[B]uffer [B]ind' },
  { '<leader>bg', '<cmd>BufferPick<cr>', mode = { 'n' }, desc = '[B]uffer [G]oto' },
  { '<leader>br', '<cmd>BufferRestore<cr>', mode = { 'n' }, desc = '[B]uffer [R]estore' },
  { '<leader>vy', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = '[V]cs [Y]ank' },
  { '<leader>vY', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = '[V]cs open [Y]ank in browser' },
  { '<leader>vB', '<cmd>Gitsigns blame<cr>', mode = { 'n' }, desc = '[V]cs [B]lame' },
  { '<leader>vb', '<cmd>Gitsigns blame_line<cr>', mode = { 'n' }, desc = '[V]cs [B]lame line' },
  { '<leader>vp', '<cmd>Gitsigns preview_hunk<cr>', mode = { 'n' }, desc = '[V]cs [P]review hunk' },
  { 'gd', vim.lsp.buf.definition, mode = { 'n' }, desc = '[G]oto [D]efinition' },
  { 'gD', vim.lsp.buf.declaration, mode = { 'n' }, desc = '[G]oto [D]eclaration' },
  { 'gt', vim.lsp.buf.type_definition, mode = { 'n' }, desc = '[G]oto [T]ype definition' },
  { '<leader>rr', vim.lsp.buf.rename, mode = { 'n' }, desc = '[R]ename symbol' },
  { '<A-t>', minuet_actions.accept, mode = { 'n', 'i' }, desc = '[M]inuet Accept Completion' },
  { '<A-[>', minuet_actions.prev, mode = { 'n', 'i' }, desc = '[M]inuet Previous Completion' },
  { '<A-]>', minuet_actions.next, mode = { 'n', 'i' }, desc = '[M]inuet Next Completion' },
  { '<A-l>', minuet_actions.dismiss, mode = { 'n', 'i' }, desc = '[M]inuet Dismiss Completion' },
  {
    'zp',
    function()
      require('ufo').peekFoldedLinesUnderCursor()
    end,
    mode = { 'n' },
    desc = 'Peek fold',
  },
}
