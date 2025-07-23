local map = vim.keymap.set

local get_max_width = function()
  return math.floor(vim.fn.winwidth(0) / 1.3)
end

map('n', ';', ':')
map('n', '<esc>', '<cmd>nohlsearch<cr>')

map('n', 'K', function()
  vim.lsp.buf.hover {
    border = 'rounded',
    title = 'docs',
    max_width = get_max_width(),
    wrap = true,
  }
end, { desc = 'Hover' })

map('n', '<leader>s', '', { desc = '[S]earch' })
map('n', '<leader>c', '', { desc = '[C]ode' })
map('n', '<leader>t', '', { desc = '[T]oggle' })
map('n', '<leader>b', '', { desc = '[B]uffer' })
map('n', '<leader>a', '', { desc = '[A]I' })

map('n', '<leader>bp', '<Cmd>BufferMovePrevious<CR>', { desc = '[B]uffer [P]revious' })
map('n', '<leader>bn', '<Cmd>BufferMoveNext<CR>', { desc = '[B]uffer [N]ext' })
map('n', '<leader>bb', '<Cmd>BufferPin<CR>', { desc = '[B]uffer [B]ind' })
map('n', '<leader>bg', '<Cmd>BufferPick<CR>', { desc = '[B]uffer [G]oto' })
map('n', '<leader>br', '<Cmd>BufferRestore<CR>', { desc = '[B]uffer [R]estore' })
map('n', '<C-h>', '<cmd>BufferPrevious<cr>', { desc = 'Previous buffer' })
map('n', '<C-l>', '<cmd>BufferNext<cr>', { desc = 'Next buffer' })
map('n', '<leader>x', '<cmd>BufferClose<cr>', { desc = 'Close buffer' })

map('n', '<leader>tn', '<cmd>set relativenumber!<cr>', { desc = '[T]oggle relative [N]umber lines' })
map('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = '[T]oggle [D]iagnostic' })
map('n', '<leader>ti', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = '[T]oggle [I]nlay hint' })
map('n', '<leader>tc', function()
  if vim.o.colorcolumn == '' then
    vim.o.colorcolumn = '80,100,120'
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = 'gray' })
  else
    vim.o.colorcolumn = ''
  end
end, { desc = '[T]oggle color [C]olumn' })

local reset_diagnostic_config_aucmd = vim.schedule_wrap(function()
  vim.diagnostic.config { virtual_lines = { current_line = true } }
  vim.api.nvim_create_autocmd('CursorMoved', {
    once = true,
    callback = function()
      vim.diagnostic.config { virtual_lines = false }
    end,
  })
end)

map('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
  reset_diagnostic_config_aucmd()
end, { desc = 'Previous [D]iagnostic message' })

map('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
  reset_diagnostic_config_aucmd()
end, { desc = 'Next [D]iagnostic message' })

map('n', '<leader>ce', function()
  vim.diagnostic.open_float { border = 'rounded', max_width = get_max_width(), title = 'diagnostic' }
end, { desc = 'Show [C]ode diagnostic [E]rror messages' })

map('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open [C]ode diagnostic [Q]uickfix' })

map('n', '<leader>cf', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[C]ode [F]ormat' })

map({ 'n', 'v' }, '<leader>vy', '<cmd>GitLink<cr>', { desc = '[V]cs [Y]ank' })
map({ 'n', 'v' }, '<leader>vY', '<cmd>GitLink!<cr>', { desc = '[V]cs open [Y]ank in browser' })
map('n', '<leader>vB', '<cmd>Gitsigns blame<cr>', { desc = '[V]cs [B]lame' })
map('n', '<leader>vb', '<cmd>Gitsigns blame_line<cr>', { desc = '[V]cs [B]lame line' })
map('n', '<leader>vp', '<cmd>Gitsigns preview_hunk<cr>', { desc = '[V]cs [P]review hunk' })

map('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
map('n', 'gt', vim.lsp.buf.type_definition, { desc = '[G]oto [T]ype definition' })
map('n', '<leader>rr', vim.lsp.buf.rename, { desc = '[R]ename symbol' })

map('n', 'zp', function()
  require('ufo').peekFoldedLinesUnderCursor()
end, { desc = 'Peek fold' })
