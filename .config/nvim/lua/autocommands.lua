vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client and client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
        buffer = 0,
        group = vim.api.nvim_create_augroup('lsp-autocommands', { clear = true }),
        callback = function()
          vim.lsp.codelens.refresh { bufnr = 0 }
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.schedule(function()
      local cursor_line = vim.fn.line '.'
      if vim.fn.foldclosed(cursor_line) ~= -1 then
        vim.cmd 'normal! zo'
      end
    end)
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'csproj', 'props', 'xml' },
  callback = function()
    local server_path = '/home/mvs/source/playground/CsprojLsp/src/Server/bin/Release/net10.0/linux-x64/publish/Server'

    vim.lsp.start {
      name = 'csproj-ls',
      cmd = { server_path },
      root_dir = vim.fn.getcwd(),
    }

    vim.lsp.set_log_level(vim.log.levels.TRACE)
  end,
})
