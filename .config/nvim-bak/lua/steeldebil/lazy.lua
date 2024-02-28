local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "steeldebil.plugins" },
  { import = "steeldebil.plugins.lsp" },
})
  --"folke/which-key.nvim",
  --"nvim-lualine/lualine.nvim",
  --"nvim-tree/nvim-tree.lua",
  --"nvim-tree/nvim-web-devicons",
  --"neovim/nvim-lspconfig",
  --"Decodetalkers/csharpls-extended-lsp.nvim",
  --"echasnovski/mini.indentscope",
