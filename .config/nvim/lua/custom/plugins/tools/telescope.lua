return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'nvim-telescope/telescope-file-browser.nvim' },
    },

    config = function()
      local get_telescope_width = function()
        return math.min(math.floor(vim.fn.winwidth(0) * 0.95), 130 + 60)
      end

      local preview_width = function()
        local available_cols_for_preview = vim.fn.winwidth(0) * 0.9 - 60
        return math.min(math.floor(available_cols_for_preview), 130)
      end

      require('telescope').setup {
        defaults = {
          dynamic_preview_title = true,
          path_display = { 'tail' },
          fname_width = 60,
          initial_mode = 'normal',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              height = 0.95,
              preview_cutoff = 120,
              prompt_position = 'bottom',
              width = get_telescope_width(),
              preview_width = preview_width(),
            },
            vertical = {
              height = 0.95,
              preview_cutoff = 40,
              prompt_position = 'top',
              width = get_telescope_width(),
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {
              previewer = true,
            },
          },
          file_browser = {
            grouped = true,
            -- this doesn't work for some reason
            -- display_stat = { date = false, size = false, mode = true },
            display_stat = false,
            cwd_to_path = true,
            path = '%:p:h',
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'file_browser')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>fb', function()
        require('telescope').extensions.file_browser.file_browser()
      end, { desc = '[F]ile [B]rowser' })
      vim.keymap.set('n', '<leader>sb', function()
        builtin.buffers {
          sort_mru = true,
          path_display = { 'tail' },
          fname_width = 60,
        }
      end, { desc = '[S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sl', builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch [L]sp symbols' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files {
          initial_mode = 'insert',
          find_command = {
            'fd',
            '--type',
            'f',
            '--hidden',
            '--exclude',
            '.git',
          },
        }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', 'gi', function()
        builtin.lsp_implementations {
          path_display = { 'tail' },
          fname_width = 60,
        }
      end, { desc = '[G]oto [I]mplementation' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function()
        builtin.live_grep { initial_mode = 'insert' }
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.builtin, { desc = 'Telescope pickers' })
      vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover {
          border = 'rounded',
          title = 'docs',
          max_width = math.floor(vim.fn.winwidth(0) / 1.3),
          wrap = true,
        }
      end, { desc = 'LSP Hover' })

      vim.keymap.set('n', 'gr', function()
        builtin.lsp_references {
          -- this shit is inverted, so include_current_line = true means do not include current line
          include_current_line = true,
          include_declaration = false,
          path_display = { 'tail' },
          fname_width = 60,
          show_line = false,
        }
      end, { desc = '[G]oto [R]eferences' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find {
          winblend = 0,
          previewer = false,
          initial_mode = 'insert',
        }
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
          initial_mode = 'insert',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      local function grep_inside_quotes()
        -- Получить текущую строку под курсором
        local line = vim.api.nvim_get_current_line()
        local col = vim.fn.col '.'

        local quote_chars = { ['"'] = true, ["'"] = true }

        local start_pos = nil
        local end_pos = nil
        local quote_char = nil

        for i = col, 1, -1 do
          local c = line:sub(i, i)
          if quote_chars[c] then
            start_pos = i
            quote_char = c
            break
          end
        end

        if start_pos == nil then
          return nil
        end

        -- Ищем конец кавычек
        for i = start_pos + 1, #line do
          local c = line:sub(i, i)
          if c == quote_char then
            end_pos = i
            break
          end
        end

        if end_pos == nil then
          return nil
        end

        -- Извлекаем текст внутри кавычек
        local text_in_quotes = line:sub(start_pos + 1, end_pos - 1)
        builtin.live_grep { default_text = text_in_quotes }
      end

      vim.keymap.set('n', '<leader>sq', grep_inside_quotes, { desc = '[S]earch [Q]uotes' })
    end,
  },
}
