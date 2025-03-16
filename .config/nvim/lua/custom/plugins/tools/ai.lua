local gemini_prompt = [[
You are a very high quality code completion engine. 
Provide **only** code suggestions matching these rules:
1. Analyze <contextBeforeCursor> and <contextAfterCursor> to infer logical structure
2. PRESERVE original code style exactly
3. PREVENT duplication with existing code
4. Respond ONLY with code, no explanations

All code you write MUST be of the best quality.
If the code is not of the best quality, you will be fined $1000.

- `<contextBeforeCursor>`: Code context before the cursor
- `<cursorPosition>`: Current cursor location
- `<contextAfterCursor>`: Code context after the cursor
]]

local gemini_chat_input_template =
  '{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}'

return {
  {
    'monkoose/neocodeium',
    enabled = false,
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
    'milanglacier/minuet-ai.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    enabled = true,
    opts = {
      virtual_text = {
        auto_trigger_ft = {},
        show_on_completion_menu = false,
      },
      provider = 'gemini',
      -- provider = 'openai_compatible',
      context_window = 8000,
      request_timeout = 5,
      n_completions = 2,
      notify = 'debug',
      provider_options = {
        openai_compatible = {
          model = 'anthropic/claude-3.5-sonnet',
          end_point = 'https://openrouter.ai/api/v1/chat/completions',
          api_key = 'OPENROUTER_KEY',
          stream = true,
          name = 'openrouter',
          optional = {
            max_tokens = 256,
            temperature = 1,
          },
        },
        gemini = {
          model = 'gemini-2.0-flash',
          stream = true,
          api_key = 'GEMINI_API_KEY',
          system = {
            prompt = gemini_prompt,
          },
          chat_input = {
            template = gemini_chat_input_template,
          },
          optional = {
            generationConfig = {
              maxOutputTokens = 400,
              topP = 0.9,
            },
          },
        },
      },
    },
  },
  {
    'Davidyz/VectorCode',
    event = 'VeryLazy',
    version = '*', -- optional, depending on whether you're on nightly or release
    dependencies = { 'nvim-lua/plenary.nvim' },
    build = 'pipx upgrade vectorcode',
    opts = {},
  },
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    event = 'InsertEnter',
    opts = {},
  },
  {
    'yetone/avante.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    enabled = true,
    event = 'VeryLazy',
    build = 'make',
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'gemini',
      cursor_applying_provider = 'gemini',
      behaviour = {
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      gemini = {
        model = 'gemini-2.0-flash',
        api_key_name = 'GEMINI_API_KEY',
        endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
        temperature = 0.5,
        max_tokens = 62000,
      },
    },
  },
}
