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
  {
    'tpope/vim-sleuth',
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  'folke/which-key.nvim',
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = true,
      notify_no_formatters = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 1000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        fsharp = { 'fantomas' },
        markdown = { 'markdownlint' },
        sql = { 'sqlfmt' },
        sh = { 'shfmt' },
        json = { 'jq' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
      },
      formatters = {
        injected = {
          options = {
            ignore_errors = false,
            -- map of treesitter language to file extension
            lang_to_ext = {
              json = 'json',
              bash = 'sh',
              c_sharp = 'cs',
              markdown = 'md',
              typescript = 'ts',
              sql = 'sql',
            },
          },
        },
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    -- priority = 1000,
    config = function()
      require('nightfox').setup {
        options = {
          styles = {
            comments = 'italic',
            constants = 'bold',
          },
        },
      }
      -- vim.cmd.colorscheme 'carbonfox'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {
        options = {
          styles = {
            comments = 'italic',
          },
          transparent = true,
        },
      }
      vim.cmd.colorscheme 'github_dark_high_contrast'
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require 'nvim-autopairs'
      local Rule = require 'nvim-autopairs.rule'
      local cond = require 'nvim-autopairs.conds'

      npairs.setup()

      npairs.add_rule(Rule('<', '>', {
        -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
        -- so that it doesn't conflict with nvim-ts-autotag
        '-html',
        '-javascriptreact',
        '-typescriptreact',
      }):with_pair(
        -- regex will make it so that it will auto-pair on
        -- `a<` but not `a <`
        -- The `:?:?` part makes it also
        -- work on Rust generics like `some_func::<T>()`
        cond.before_regex('%a+:?:?$', 3)
      ):with_move(function(opts)
        return opts.char == '>'
      end))
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    opts = {
      max_lines = 10,
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    enabled = true,
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      close_fold_kinds_for_ft = {
        default = {
          'imports',
          'comment',
          -- 'implementation',
        },
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    opts = {
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filesize', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },
  {
    -- TODO: add keymaps because there is no deafult keymaps
    'romgrk/barbar.nvim',
    event = 'VeryLazy',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      auto_hide = 1,
      tabpages = true,
      focus_on_close = 'previous',
      maximum_padding = 0,
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      floating_window = false,
      bind = true,
      max_height = 20,
      max_width = 120,
      wrap = true,
      hint_enable = true,
      hint_prefix = {
        above = '↙ ',
        current = '← ',
        below = '↖ ',
      },
      handler_opts = {
        border = 'rounded',
      },
      padding = '',
    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    main = 'ibl',
    opts = {},
  },
  {
    'onsails/lspkind.nvim',
    opts = {},
  },
  {
    'lukas-reineke/headlines.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    enabled = true,
    cmd = {
      'MarkdownPreviewToggle',
      'MarkdownPreview',
      'MarkdownPreviewStop',
    },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      vim.g.mkdp_refresh_slow = 1
      vim.g.mkdp_auto_start = 0
    end,
  },
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'Issafalcon/neotest-dotnet',
    },
    version = '5.x',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-dotnet' {
            discovery_root = 'solution',
          },
        },
        log_level = 5,
      }
    end,
  },
  {
    'ionide/ionide-vim',
    event = 'VeryLazy',
  },
  {
    'pmizio/typescript-tools.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  {
    'seblj/roslyn.nvim',
    opts = {
      filewatching = false,
      config = {
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_imblicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
          },
          ['csharp|completion'] = {
            dotnet_provide_regex_completions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'openFiles',
            dotnet_compiler_diagnostics_scope = 'openFiles',
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = false,
            dotnet_enable_tests_code_lens = true,
          },
          ['navigation'] = {
            dotnet_navigate_to_decompiled_sources = true,
          },
        },
      },
    },
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {},
  },
  {
    'rmagatti/goto-preview',
    event = 'BufEnter',
    config = true,
    opts = {
      height = 40,
      width = 130,
      default_mappings = true,
      focus_on_open = true,
      dismiss_on_move = false,
    },
  },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '/' },
      auto_save = true,
      log_level = 'error',
      use_git_branch = true,
      close_unsupported_windows = true,
    },
  },
  {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    opts = {},
    keys = {
      { '<leader>gY', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link' },
    },
  },
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    enabled = true,
    opts = {
      -- get_sdk_path = function()
      --   return '/usr/share/dotnet/sdk/8.0.404'
      -- end,
      test_runner = {
        viewmode = 'float',
        noBuild = false,
        noRestore = false,
        enable_buffer_test_execution = true,
      },
      enable_filetypes = true,
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { plugins = { 'nvim-dap-ui' }, types = true },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    enabled = false,
    opts = {},
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  },
  {
    'stevearc/dressing.nvim',
    enabled = true,
    opts = {},
  },
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
    },
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require('symbol-usage').setup {
        request_pending_text = 'loading...',
        references = { enabled = true, include_declaration = false },
        definition = { enabled = true },
        implementation = { enabled = true },
      }
    end,
  },
  {
    'monkoose/neocodeium',
    event = 'VeryLazy',
    config = function()
      local neocodeium = require 'neocodeium'
      neocodeium.setup {
        manual = true,
      }
      vim.keymap.set('i', '<A-l>', function()
        neocodeium.accept()
      end)
      vim.keymap.set('i', '<A-]>', function()
        neocodeium.cycle_or_complete(1)
      end)
      vim.keymap.set('i', '<A-[>', function()
        neocodeium.cycle(-1)
      end)
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      completion = {
        ghost_text = {
          enabled = false,
          show_with_selection = true,
          show_without_selection = false,
        },
        keyword = {
          range = 'prefix',
        },
        trigger = {
          prefetch_on_insert = true,
          show_in_snippet = false,
          show_on_keyword = true,
        },
        list = {
          max_items = 200,
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        accept = {
          auto_brackets = {
            semantic_token_resolution = {
              enabled = true,
              timeout_ms = 400,
            },
          },
        },
        menu = {
          border = 'rounded',
          winblend = vim.o.pumblend,
          auto_show = true,
          scrolloff = 2,
          scrollbar = false,
          draw = {
            gap = 1,
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
            },
          },
        },
        documentation = {
          window = {
            border = 'rounded',
          },
          auto_show = true,
        },
      },
      signature = {
        window = {
          border = 'single',
        },
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'lazydev',
        },
        providers = {
          lsp = {
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                local cmp_item_kind = require('blink.cmp.types').CompletionItemKind

                if item.kind == cmp_item_kind.Property then
                  item.score_offset = item.score_offset + 1
                end

                if item.kind == cmp_item_kind.Operator then
                  item.score_offset = item.score_offset - 1
                end
              end

              return vim.tbl_filter(function(item)
                return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text
              end, items)
            end,
            async = true,
            timeout_ms = 300,
          },
          snippets = {
            score_offset = -10,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
    signature = {
      enabled = false,
    },
    opts_extend = { 'sources.default' },
  },
}
