return {
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
      context_window = 8000,
      request_timeout = 5,
      n_completions = 2,
      provider_options = {
        gemini = {
          model = 'gemini-2.5-flash-preview-04-17',
          stream = true,
          api_key = 'GEMINI_API_KEY',
          optional = {
            generationConfig = {
              temperature = 0.2,
              maxOutputTokens = 300,
              thinkingConfig = {
                thinkingBudget = 0,
              },
            },
          },
        },
      },
    },
  },
  {
    'yetone/avante.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    enabled = false,
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
        model = 'gemini-2.5-flash-preview-04-17',
        api_key_name = 'GEMINI_API_KEY',
        endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
        temperature = 0.25,
        max_tokens = 62000,
      },
    },
  {
    'coder/claudecode.nvim',
    -- dependencies = { 'folke/snacks.nvim' },
    event = 'VeryLazy',
    opts = {
      auto_start = true,
      log_level = 'info',
      track_selection = true,
      terminal = {
        split_side = 'right',
        split_width_percentage = 0.30,
        provider = 'native',
        auto_close = true,
      },
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true,
      },
    },
    keys = {
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = '[A]I [C]laude toggle' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = '[A]I [F]ocus Claude' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = '[A]I [S]end selection' },
      { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = '[A]I [R]esume Claude' },
      { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = '[A]I [C]ontinue Claude' },
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = '[A]I [A]ccept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = '[A]I [D]eny diff' },
    },
  },
}
