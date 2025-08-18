local function get_session_name()
  local name = vim.fn.getcwd()
  local branch = vim.trim(vim.fn.system 'git branch --show-current')
  if vim.v.shell_error == 0 then
    return name .. branch
  else
    return name
  end
end

local setup_resession_aucmd = function(resession)
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      if vim.fn.argc(-1) == 0 then
        resession.load(get_session_name(), { dir = 'dirsession', silence_errors = true })
      end
    end,
  })
  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
      resession.save(get_session_name(), { dir = 'dirsession', notify = false })
    end,
  })
end

return {
  {
    'rmagatti/auto-session',
    enabled = false,
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '/' },
      auto_save = true,
      log_level = 'error',
      use_git_branch = true,
      close_unsupported_windows = true,
    },
  },
  {
    'stevearc/resession.nvim',
    dependencies = { 'romgrk/barbar.nvim' },
    config = function()
      local cfg = {
        autosave = {
          enabled = true,
          interval = 15,
          notify = true,
        },
        buf_filter = function(bufnr)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          -- Skip roslyn buffers
          if bufname:match '/roslyn%-' or bufname:match '^roslyn%-' then
            return false
          end
          -- Use default filter for other buffers
          return require('resession').default_buf_filter(bufnr)
        end,
        extensions = {
          barbar = {},
        },
      }
      local resession = require 'resession'
      resession.setup(cfg)
      setup_resession_aucmd(resession)
    end,
    keys = {
      {
        '<leader>os',
        function()
          require('resession').save()
        end,
        desc = 'Session save',
      },
      {
        '<leader>ol',
        function()
          require('resession').load()
        end,
        desc = 'Session load',
      },
      {
        '<leader>od',
        function()
          require('resession').delete()
        end,
        desc = 'Session delete',
      },
    },
  },
}
