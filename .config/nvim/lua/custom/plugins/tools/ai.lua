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
    'folke/sidekick.nvim',
    ---@class sidekick.Config
    opts = {
      nes = {
        enabled = false,
      },
      cli = {
        picker = 'fzf-lua',
        mux = {
          backend = 'tmux',
          enabled = true,
        },
        tools = {
          codex = { cmd = { 'codex' } },
          opencode = {
            cmd = { 'opencode' },
            env = { OPENCODE_THEME = 'system' },
          },
        },
      },
    },
    keys = {
      {
        '<M-.>',
        function()
          require('sidekick.cli').toggle()
        end,
        mode = { 'n', 't', 'i', 'x' },
        desc = 'Sidekick toggle terminal (alt)',
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = '[A]I Sidekick toggle',
      },
      {
        '<leader>a.',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = '[A]I toggle terminal',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select { filter = { installed = true } }
        end,
        desc = '[A]I [S]elect CLI',
      },
      {
        '<leader>ac',
        function()
          require('sidekick.cli').toggle { name = 'codex', focus = true }
        end,
        desc = '[A]I toggle [C]odex',
      },
      {
        '<leader>ao',
        function()
          require('sidekick.cli').toggle { name = 'opencode', focus = true }
        end,
        desc = '[A]I toggle [O]penCode',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = '[A]I [P]rompt',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send { msg = '{this}' }
        end,
        mode = { 'n', 'x' },
        desc = '[A]I send [T]his',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send { msg = '{file}' }
        end,
        desc = '[A]I send [F]ile',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = { 'x' },
        desc = '[A]I send [V]isual selection',
      },
      {
        '<leader>ad',
        function()
          require('sidekick.cli').close()
        end,
        desc = '[A]I [D]etach terminal',
      },
    },
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
