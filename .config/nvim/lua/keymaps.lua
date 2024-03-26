local map = vim.keymap.set

map('n', '<leader>tn', '<cmd>set relativenumber!<CR>', { desc = '[T]oggle relative [N]umber lines' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>lf', vim.diagnostic.open_float, { desc = 'Lsp floating [D]iagnostics' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Lsp prev [D]iagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Lsp next [D]iagnostic' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Lsp [D]iagnostic loclist' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

map('n', ';', ':', { desc = 'Command mode with semicolon' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<leader>fm', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = 'Format buffer' })
