return {
  {
    'coder/claudecode.nvim',
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
