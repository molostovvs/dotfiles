local SymbolKind = vim.lsp.protocol.SymbolKind

return {
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    opts = {
      vt_position = 'end_of_line',
      kinds = {
        SymbolKind.Function,
        SymbolKind.Method,
        SymbolKind.Class,
        SymbolKind.Property,
        SymbolKind.Enum,
        SymbolKind.EnumMember,
      },
    },
  },
}
