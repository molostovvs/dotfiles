vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = 'CurSearch', timeout = 300 }
  end,
})

local lsp_attach_group = vim.api.nvim_create_augroup('lsp-attach', { clear = true })
local lsp_codelens_group = vim.api.nvim_create_augroup('lsp-codelens', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_attach_group,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client.server_capabilities.codeLensProvider then
      local function refresh_codelens()
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(event.buf) then
            vim.lsp.codelens.refresh { bufnr = event.buf }
          end
        end)
      end

      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'BufWritePost' }, {
        buffer = event.buf,
        group = lsp_codelens_group,
        callback = refresh_codelens,
      })

      refresh_codelens()
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
  pattern = { 'cs', 'csproj', 'sln', 'slnx' },
  callback = function()
    vim.cmd 'compiler dotnet'
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'csproj', 'props', 'xml' },
  callback = function()
    local server_path = '/home/mvs/source/projects/CsprojLsp/src/Server/bin/Release/net10.0/linux-x64/publish/Server'

    vim.lsp.start {
      name = 'csproj-ls',
      cmd = { server_path },
      root_dir = vim.fn.getcwd(),
    }

    vim.lsp.set_log_level(vim.log.levels.TRACE)
  end,
})

vim.api.nvim_create_autocmd('BufReadPre', {
  callback = function()
    vim.b.ufo_foldlevel = 0
  end,
})
