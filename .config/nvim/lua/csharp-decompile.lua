local config = {
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
  },
  cmd = { "csharp-ls" },
  -- rest of your settings
}

require'lspconfig'.csharp_ls.setup(config)
