---@class LineRange
---@field line integer
---@field character integer

---@class VsRange
---@field start LineRange
---@field end LineRange

---@class VsTextEdit
---@field newText string
---@field range VsRange

---@param edit VsTextEdit
local function apply_vs_text_edit(edit)
  local bufnr = vim.api.nvim_get_current_buf()
  local start_line = edit.range.start.line
  local start_char = edit.range.start.character
  local end_line = edit.range['end'].line
  local end_char = edit.range['end'].character

  local lines = vim.split(edit.newText, '\n')
  local placeholder_row = -1
  local placeholder_col = -1

  -- placeholder handling
  for i, line in ipairs(lines) do
    local pos = string.find(line, '%$0')
    if pos then
      lines[i] = string.gsub(line, '%$0', '', 1)
      placeholder_row = start_line + i - 1
      placeholder_col = pos - 1
      break
    end
  end

  vim.api.nvim_buf_set_text(bufnr, start_line, start_char, end_line, end_char, lines)

  if placeholder_row ~= -1 and placeholder_col ~= -1 then
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, { placeholder_row + 1, placeholder_col })
  end
end

vim.api.nvim_create_autocmd('InsertCharPre', {
  pattern = '*.cs',
  callback = function()
    local char = vim.v.char

    if char ~= '/' then
      return
    end

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row, col = row - 1, col + 1
    local bufnr = vim.api.nvim_get_current_buf()
    local uri = vim.uri_from_bufnr(bufnr)

    local params = {
      _vs_textDocument = { uri = uri },
      _vs_position = { line = row, character = col },
      _vs_ch = char,
      _vs_options = { tabSize = 4, insertSpaces = true },
    }

    -- NOTE: we should send textDocument/_vs_onAutoInsert request only after buffer has changed.
    vim.defer_fn(function()
      vim.lsp.buf_request(bufnr, 'textDocument/_vs_onAutoInsert', params)
    end, 1)
  end,
})

return {
  {
    'GustavEikaas/easy-dotnet.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    enabled = true,
    opts = {
      test_runner = {
        viewmode = 'float',
        noBuild = false,
        noRestore = false,
        enable_buffer_test_execution = true,
        auto_bootstrap_namespace = {
          type = 'file_scoped',
          enabled = false,
        },
        mappings = {
          run_test_from_buffer = { lhs = '<leader>tr', desc = 'trigger test run' },
        },
      },
      enable_filetypes = true,
      picker = 'fzf',
    },
  },
  {
    'seblyng/roslyn.nvim',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = 'roslyn',
    },
    config = function(_, opts)
      -- Set up vim.lsp.config for roslyn
      vim.lsp.config.roslyn = {
        capabilities = {
          textDocument = {
            _vs_onAutoInsert = { dynamicRegistration = false },
          },
        },
        handlers = {
          ['textDocument/_vs_onAutoInsert'] = function(err, result, _)
            if err or not result then
              return
            end
            apply_vs_text_edit(result._vs_textEdit)
          end,
        },
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_imblicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
          },
          ['csharp|completion'] = {
            dotnet_provide_regex_completions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'openFiles',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = false,
            dotnet_enable_tests_code_lens = false,
          },
          ['navigation'] = {
            dotnet_navigate_to_decompiled_sources = true,
          },
          ['csharp|auto_insert'] = {
            dotnet_enable_auto_insert = true,
          },
          ['csharp|formatting'] = {
            dotnet_organize_imports_on_format = true,
          },
        },
      }
      
      -- Setup roslyn.nvim with the remaining opts
      require('roslyn').setup(opts)
    end,
  },
  {
    'ionide/ionide-vim',
    event = 'VeryLazy',
  },
}
