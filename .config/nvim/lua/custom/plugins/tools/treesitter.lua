return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'c_sharp', 'sql', 'css', 'json', 'xml' },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = {
            ['[m'] = '@method_name',
          },
          goto_next_start = {
            [']m'] = '@method_name',
          },
        },
      },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.fsharp = {
        install_info = {
          url = 'https://github.com/ionide/tree-sitter-fsharp',
          branch = 'main',
          files = { 'src/scanner.c', 'src/parser.c' },
          location = 'fsharp',
        },
        requires_generate_from_grammar = false,
        filetype = 'fsharp',
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
}
