local function get_text_in_quotes()
  -- get current line and column
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col '.'

  local quote_chars = { ['"'] = true, ["'"] = true }

  local start_pos = nil
  local end_pos = nil
  local quote_char = nil

  for i = col, 1, -1 do
    local c = line:sub(i, i)
    if quote_chars[c] then
      start_pos = i
      quote_char = c
      break
    end
  end

  if start_pos == nil then
    return nil
  end

  -- find end quote
  for i = start_pos + 1, #line do
    local c = line:sub(i, i)
    if c == quote_char then
      end_pos = i
      break
    end
  end

  if end_pos == nil then
    return nil
  end

  -- extract text
  local text_in_quotes = line:sub(start_pos + 1, end_pos - 1)
  return text_in_quotes
end

return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      winopts = {
        width = 0.98,
        height = 0.98,
        backdrop = 85,
        preview = {
          layout = 'vertical',
          vertical = 'down:60%',
          delay = 30,
        },
      },
      files = {
        path_shorten = 10,
        git_icons = true,
      },
      previewers = {
        builtin = {
          title_fnamemodify = function(s)
            return s
          end,
        },
      },
    },
    config = function(_, opts)
      require('fzf-lua').setup(opts)
      require('fzf-lua').register_ui_select()
    end,
    keys = {
      { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = '[S]earch [G]rep' },
      { '<leader><leader>', '<cmd>FzfLua buffers<cr>', desc = 'Search open buffers' },
      { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = '[S]earch [K]eymaps' },
      { '<leader>sf', '<cmd>FzfLua files git_icons=true<cr>', desc = '[S]earch [F]iles' },
      {
        '<leader>sF',
        function()
          require('fzf-lua').files { cwd = vim.fn.expand '%:p:h' }
        end,
        desc = '[S]earch [F]iles from current file cwd',
      },
      { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = '[S]earch [R]esume' },
      { '<leader>sde', '<cmd>FzfLua lsp_workspace_diagnostics severity_limit=ERROR<cr>', desc = '[S]earch [D]iagnostics [E]rror' },
      { '<leader>sdw', '<cmd>FzfLua lsp_workspace_diagnostics severity_limit=WARN<cr>', desc = '[S]earch [D]iagnostics [W]arn' },
      { '<leader>sda', '<cmd>FzfLua lsp_workspace_diagnostics severity_bound=INFO<cr>', desc = '[S]earch [D]iagnostics [A]ll' },
      { '<leader>sl', '<cmd>FzfLua lsp_live_workspace_symbols<cr>', desc = '[S]earch [L]ive workspace symbols' },
      { '<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>', desc = '[C]ode [A]ctions' },
      { '<leader>ds', '<cmd>FzfLua lsp_document_symbols<cr>', desc = '[D]ocument [S]ymbols' },
      { '<leader>ws', '<cmd>FzfLua lsp_workspace_symbols<cr>', desc = '[W]orkspace [S]ymbols' },
      { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = '[S]earch [W]ord' },
      { '<leader>so', '<cmd>FzfLua oldfiles<cr>', desc = '[S]earch [O]ldfiles' },
      { '<leader>/', '<cmd>FzfLua lgrep_curbuf<cr>', desc = 'Live grep current buffer' },
      {
        'gi',
        '<cmd>FzfLua lsp_implementations async_or_timeout=true includeDeclaration=false ignore_current_line=true<cr> ',
        desc = '[G]o to [I]mplementations',
      },
      {
        'gd',
        '<cmd>FzfLua lsp_definitions async_or_timeout=true includeDeclaration=false ignore_current_line=true<cr> ',
        desc = '[G]o to [I]mplementations',
      },
      {
        'gr',
        '<cmd>FzfLua lsp_references async_or_timeout=true includeDeclaration=false ignore_current_line=true<cr>',
        desc = '[G]o to [R]eferences',
      },
      { '<leader>sv', '<cmd>FzfLua grep_visual<cr>', mode = { 'v' }, desc = '[S]earch [V]isual selection' },
      {
        '<leader>sq',
        function()
          local text_in_quotes = get_text_in_quotes()
          if text_in_quotes == nil then
            vim.notify 'No text in quotes found'
            return
          end
          require('fzf-lua').grep { search = text_in_quotes }
        end,
        desc = '[S]earch [Q]uotes',
      },
    },
  },
}
