return {
  {
    'monkoose/neocodeium',
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
}
