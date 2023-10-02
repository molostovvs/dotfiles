return {
  {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    sort_by = "case_sensitive",
    view = {
      width = 30,
    }
  },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "neovim/nvim-lspconfig",
  "Decodetalkers/csharpls-extended-lsp.nvim",
}
