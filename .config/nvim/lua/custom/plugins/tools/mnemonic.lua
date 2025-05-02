return {
  {
    'molostovvs/mnemonic.nvim',
    lazy = false,
    ---@module 'mnemonic.init'
    ---@type MnemonicConfig
    opts = {},
    keys = {
      {
        'mm',
        function()
          require('mnemonic.ui').add_bookmark()
        end,
        desc = '[B]ookmark [C]reate',
      },
      {
        'md',
        function()
          require('mnemonic.bookmarks').remove_bookmark()
        end,
        desc = '[B]ookmark [D]elete',
      },
      {
        'mp',
        function()
          require('mnemonic.bookmarks').show_bookmarks()
        end,
        desc = '[B]ookmarks [P]rint',
      },
    },
  },
}
