local map = vim.keymap.set

map('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>', { desc = '[T]oggle file [T]ree' })

-- options for ufo
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- keymap for barbar
map('n', '<C-PageUp>', '<cmd>BufferPrevious<CR>', { desc = 'Go to previous tab' })
map('n', '<C-PageDown>', '<cmd>BufferNext<CR>', { desc = 'Go to next tab' })
map('n', '<leader>x', '<cmd>BufferClose<CR>', { desc = 'Close buffer' })

-- keymap for actions-preview
map({ 'v', 'n' }, '<leader>cp', function()
  require('actions-preview').code_actions()
end, { desc = '[L]sp [C]ode actions [P]review' })

-- keymap for lsp_lines
map('n', '<leader>ll', function()
  vim.diagnostic.config {
    virtual_text = not vim.diagnostic.config()['virtual_text'],
    virtual_lines = not vim.diagnostic.config()['virtual_lines'],
  }
end, { desc = 'Toggle [L]sp [L]ines' })

-- function for keymaps of nvim-tree
local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  map('n', '<left>', api.node.navigate.parent_close, opts 'Close directory')
  map('n', '<right>', api.node.open.edit, opts 'Open directory')
end

return {
  -- {
  --   'tpope/vim-sleuth',
  -- },
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
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      }
    end,
  },
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
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
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
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    opts = {
      on_attach = my_on_attach,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      sort = { sorter = 'name', folders_first = true },
      view = { width = 30, side = 'right' },
      renderer = {
        group_empty = false,
        indent_markers = { enable = true },
        indent_width = 1,
        highlight_git = true,
        root_folder_label = true,
        icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
      },
      filters = { dotfiles = false },
      git = { enable = true, ignore = true },
    },
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
      map_cr = true,
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
    opts = {},
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
    keys = {
      {
        '<leader>ll',
        function()
          require('lsp_lines').toggle()
        end,
        { desc = 'Toggle [L]sp [L]ines' },
      },
    },
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
    cmd = 'Copilot',
    event = 'VeryLazy',
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = false,
        debounce = 10,
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        vb = true,
        cs = true,
        lua = true,
        ['*'] = false,
      },
    },
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
}
