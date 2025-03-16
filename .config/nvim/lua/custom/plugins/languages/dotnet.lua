--- @param client vim.lsp.Client the LSP client
local function monkey_patch_semantic_tokens(client)
  -- NOTE: Super hacky
  if client.is_hacked then
    return
  end
  client.is_hacked = true

  -- let the runtime know the server can do semanticTokens/full now
  client.server_capabilities = vim.tbl_deep_extend('force', client.server_capabilities, {
    semanticTokensProvider = {
      full = true,
    },
  })

  -- monkey patch the request proxy
  local request_inner = client.request
  function client:request(method, params, handler, req_bufnr)
    if method ~= vim.lsp.protocol.Methods.textDocument_semanticTokens_full then
      return request_inner(self, method, params, handler)
    end

    local target_bufnr = vim.uri_to_bufnr(params.textDocument.uri)
    local line_count = vim.api.nvim_buf_line_count(target_bufnr)
    local last_line = vim.api.nvim_buf_get_lines(target_bufnr, line_count - 1, line_count, true)[1]

    return request_inner(self, 'textDocument/semanticTokens/range', {
      textDocument = params.textDocument,
      range = {
        ['start'] = {
          line = 0,
          character = 0,
        },
        ['end'] = {
          line = line_count - 1,
          character = string.len(last_line) - 1,
        },
      },
    }, handler, req_bufnr)
  end
end

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
      ---@diagnostic disable-next-line: missing-fields
      config = {
        on_attach = function(client, _)
          monkey_patch_semantic_tokens(client)
        end,
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
            dotnet_compiler_diagnostics_scope = 'openFiles',
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = false,
            dotnet_enable_tests_code_lens = false,
          },
          ['navigation'] = {
            dotnet_navigate_to_decompiled_sources = true,
          },
        },
      },
    },
  },
  {
    'ionide/ionide-vim',
    event = 'VeryLazy',
  },
}
