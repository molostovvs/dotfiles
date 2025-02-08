return {
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
          max_height = 15,
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
