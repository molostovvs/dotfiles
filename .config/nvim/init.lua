require 'options'
require 'autocommands'
require 'lazy-boot'

require('lazy').setup {
  spec = {
    require 'custom.plugins',
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  checker = {
    enabled = true,
    frequency = 60 * 60 * 8,
  },
  profiling = {
    loader = true,
  },
}

require 'keymaps'
