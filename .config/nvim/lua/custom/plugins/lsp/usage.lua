return {
  {
    'Wansmer/symbol-usage.nvim',
    enabled = false,
    event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require('symbol-usage').setup {
        request_pending_text = 'loading...',
        references = { enabled = true, include_declaration = false },
        definition = { enabled = true },
        implementation = { enabled = true },
        vt_position = 'end_of_line',
      }
    end,
  },
}
