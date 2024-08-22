local map = vim.keymap.set

-- options for ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- keymap for barbar

return {
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
      keys = {
        '<leader>fm',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer',
      },
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
        -- cs = { 'csharpier' },
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
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup()
      vim.cmd.colorscheme 'tokyonight-night'
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
    opts = {
      enable_check_bracket_line = false,
      ignored_next_char = '[%w%.]',
    },
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
    opts = {
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filesize', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
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
    opts = {
      floating_window = false,
      bind = true,
      max_height = 20,
      max_width = 120,
      wrap = true,
      handler_opts = {
        border = 'double',
      },
      padding = '',
      -- this doesnt work
      -- select_signature_key = '<M-x',
      toggle_key = '<M-f>',
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
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    enabled = true,
    lazy = true,
    opts = {},
  },
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    opts = {
      api_key_cmd = 'cat /home/mvs/chatgpt.api',
      openai_params = {
        model = 'gpt-3.5-turbo-1106',
        temperature = 0.3,
        top_p = 1,
        max_tokens = 2000,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'aznhe21/actions-preview.nvim',
    opts = {
      telescope = {
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = 'top',
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    },
  },
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    cmd = 'Copilot',
    event = 'VeryLazy',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 10,
      },
      panel = {
        enabled = false,
        auto_refresh = true,
      },
      filetypes = {
        vb = true,
        cs = true,
        lua = true,
        ['*'] = false,
      },
    },
    config = function(_, opts)
      vim.g.copilot_proxy = 'proxy_user:mUFKoymUKX@79.137.199.192:31974'
      require('copilot').setup(opts)
    end,
  },
  {
    'Hoffs/omnisharp-extended-lsp.nvim',
  },
  {
    'onsails/lspkind.nvim',
  },
  {
    'zbirenbaum/copilot-cmp',
    opts = {},
  },
  {
    'lukas-reineke/headlines.nvim',
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
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    'lewis6991/hover.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      init = function()
        require 'hover.providers.lsp'
        require 'hover.providers.man'
        require 'hover.providers.diagnostic'
        require 'hover.providers.fold_preview'
        require 'hover.providers.gh'
        require 'hover.providers.gh_user'
      end,
      preview_opts = {
        border = 'single',
      },
      title = true,
      preview_window = true,
    },
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>fb', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', desc = '[F]ile [B]rowser' },
    },
  },
  { 'Issafalcon/neotest-dotnet' },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'Issafalcon/neotest-dotnet',
    },
    opts = function()
      adapters = {
        require 'neotest-dotnet' {},
      }
      loglevel = 1
    end,
  },
  { 'ionide/ionide-vim' },
  { 'pmizio/typescript-tools.nvim' },
  {
    'seblj/roslyn.nvim',
    opts = function()
      require('roslyn').setup {
        exe = {
          'dotnet',
          vim.fs.joinpath(vim.fn.stdpath 'data', 'roslyn', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
        },
      }
    end,
  },
}
