return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    -- branch = 'main',
    -- build = 'cargo build --release',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function()
        return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
      end,
      fuzzy = {
        implementation = 'rust',
        -- 'exact' also can be used here
        sorts = { 'score', 'exact', 'sort_text' },
        -- Proximity bonus boosts the score of items matching nearby words
        use_proximity = true,
        -- Frecency tracks the most recently/frequently used items and boosts the score of the item
        frecency = {
          enabled = true,
        },
      },
      keymap = {
        preset = 'default',
        ['<C-space>'] = { 'show', 'hide' },
        ['<C-k>'] = { 'show_documentation', 'hide_documentation' },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
        ['<C-d>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      completion = {
        ghost_text = {
          enabled = false,
        },
        keyword = {
          range = 'prefix',
        },
        trigger = {
          prefetch_on_insert = true,
          show_in_snippet = false,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_blocked_trigger_characters = { '\t' },
          show_on_x_blocked_trigger_characters = { "'", '"' },
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
          max_height = 15,
          border = 'rounded',
          winblend = vim.o.pumblend,
          auto_show = true,
          scrolloff = 2,
          scrollbar = true,
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

                if item.kind == cmp_item_kind.Property or item.kind == cmp_item_kind.Field then
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
            async = false,
          },
          snippets = {
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= 'trigger_character'
            end,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
        transform_items = function(_, items)
          return items
        end,
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
          border = 'rounded',
        },
        trigger = {
          enabled = true,
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'saghen/blink.compat',
    lazy = true,
    version = false,
  },
}
