return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 2000,
        request_timeout = 1,
        throttle = 500,
        debounce = 500,
        notify = 'warn',
        virtualtext = {
          keymap = {
            accept = '<A-t>',
            accept_line = '<A-l>',
            next = '<A-]>',
            prev = '<A-[>',
            dismiss = '<A-e>'
          },
        },
        provider_options = {
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:7b',
            optional = {
              max_tokens = 128,
              top_p = 0.95,
            },
          },
        },
      }
    end,
  },
  {
    'coder/claudecode.nvim',
    enabled = false,
    event = 'VeryLazy',
    opts = {
      auto_start = true,
      log_level = 'info',
      track_selection = true,
      focus_after_send = true,
      terminal = {
        split_side = 'right',
        split_width_percentage = 0.35,
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
