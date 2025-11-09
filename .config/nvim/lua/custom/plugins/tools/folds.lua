---@param num integer Set the fold level to this number
local set_buf_foldlevel = function(num)
  vim.b.ufo_foldlevel = num
  require('ufo').closeFoldsWith(num)
end

---@param num integer The amount to change the UFO fold level by
local change_buf_foldlevel_by = function(num)
  local foldlevel = vim.b.ufo_foldlevel or 0
  -- Ensure the foldlevel can't be set negatively
  if foldlevel + num >= 0 then
    foldlevel = foldlevel + num
  else
    foldlevel = 0
  end
  set_buf_foldlevel(foldlevel)
end

return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
      provider_selector = function(_, _, _)
        return { 'lsp' }
      end,
      close_fold_kinds_for_ft = {
        default = {
          'implementation', -- it is very badly implemented.
          'imports',
          'comment',
          -- 'region',
        },
      },
      enable_get_fold_virt_text = {
        default = true,
      },
    },
    config = function(opts)
      local ufo = require 'ufo'
      ufo.setup(opts)

      vim.keymap.set('n', 'zp', ufo.peekFoldedLinesUnderCursor, { desc = '[UFO] Peek fold' })
      vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = '[UFO] Open all folds' })
      vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = '[UFO] Close all folds' })

      -- vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = '[UFO] Open folds' })
      -- vim.keymap.set('n', 'zm', ufo.closeFoldsWith, { desc = '[UFO] Close folds' })

      -- below is the code from the https://github.com/kevinhwang91/nvim-ufo/issues/150#issuecomment-1867928299
      vim.keymap.set('n', 'zm', function()
        local count = vim.v.count
        if count == 0 then
          count = 1
        end
        change_buf_foldlevel_by(-count)
      end, { desc = 'UFO: Fold More' })

      vim.keymap.set('n', 'zr', function()
        local count = vim.v.count
        if count == 0 then
          count = 1
        end
        change_buf_foldlevel_by(count)
      end, { desc = 'UFO: Fold Less' })
    end,
  },
  -- {
  --   'chrisgrieser/nvim-origami',
  --   enabled = false,
  --   event = 'VeryLazy',
  --   opts = {}, -- needed even when using default config
  --   init = function()
  --     vim.opt.foldlevel = 99
  --     vim.opt.foldlevelstart = 99
  --   end,
  -- },
}
