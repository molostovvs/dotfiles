return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'j-hui/fidget.nvim' },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rr', vim.lsp.buf.rename, '[R]ename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

      local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local servers = {
        docker_compose_language_service = {},
        roslyn = {},
        terraformls = {},
        bashls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Both',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
              },
              hint = {
                enable = true,
              },
            },
          },
        },
      }

      require('mason').setup {
        ui = {
          border = 'rounded',
        },
        registries = {
          'github:mason-org/mason-registry',
          'github:crashdummyy/mason-registry',
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'jq',
        'prettier',
        'eslint_d',
        'sqlfmt',
        'jsonlint',
        'markdownlint',
        'netcoredbg',
        'hadolint',
        'luacheck',
        'selene',
        'tflint',
        'actionlint',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
