return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    local csharpconf = {
      handlers = {
        ["textDocument/definition"] = require('csharpls_extended').handler,
      },
      cmd = { "csharp-ls" }
    }

    lspconfig.csharp_ls.setup(csharpconf)
    lspconfig.lua_ls.setup {}
  end,
}
