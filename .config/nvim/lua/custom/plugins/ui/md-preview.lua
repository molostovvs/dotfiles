return {
  {
    'iamcco/markdown-preview.nvim',
    enabled = true,
    cmd = {
      'MarkdownPreviewToggle',
      'MarkdownPreview',
      'MarkdownPreviewStop',
    },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      vim.g.mkdp_refresh_slow = 1
      vim.g.mkdp_auto_start = 0
    end,
  },
}
