return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 4096,
        request_timeout = 3,
        notify = 'warn',
        virtualtext = {
          auto_trigger_ft = { '*' },
          keymap = {
            accept = '<A-t>',
            accept_line = '<A-l>',
            next = '<A-]>',
            prev = '<A-[>',
            dismiss = '<A-e>',
          },
        },
        provider_options = {
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Llama.cpp',
            end_point = 'http://localhost:8012/v1/completions',
            model = 'qwen2.5-coder-7b-instruct',
            optional = {
              max_tokens = 512,
            },
            template = {
              prompt = function(context_before_cursor, context_after_cursor, _)
                local system_prompt = '<|im_start|>system\n'
                  .. 'You are a code completion tool. '
                  .. 'Complete the code naturally. If the cursor is inside a function, finish the logic. '
                  .. 'If the cursor is at the class level, you may suggest a new method. '
                  .. 'Stop immediately after completing one logical unit.\n'
                  .. '<|im_end|>\n'

                return system_prompt .. '<|fim_prefix|>' .. context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
              end,
              suffix = false,
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
        '<leader>as',
        function()
          require('sidekick.cli').select { filter = { installed = true } }
        end,
        desc = '[A]I [S]elect CLI',
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
}
