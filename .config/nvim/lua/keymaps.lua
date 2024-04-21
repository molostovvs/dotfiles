local map = vim.keymap.set

map('n', '<leader>tn', '<cmd>set relativenumber!<CR>', { desc = '[T]oggle relative [N]umber lines' })

map('n', '<leader>tc', function()
  if vim.o.colorcolumn == '' then
    vim.o.colorcolumn = '80,100'
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = 'gray' })
  else
    vim.o.colorcolumn = ''
  end
end, { desc = '[T]oggle color [C]olumn' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Lsp floating [D]iagnostics' })

map('n', ';', ':', { desc = 'Command mode with semicolon' })

map('n', '<leader>fm', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = 'Format buffer' })
