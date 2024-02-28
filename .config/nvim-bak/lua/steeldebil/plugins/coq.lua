vim.g.coq_settings = {
  auto_start = 'shut-up',
  completion = {
    always = false,
    replace_prefix_threshold = 10,
    replace_suffix_threshold = 10,
  },
  keymap = {
    pre_select = true,
  },
  clients = {
    lsp = {
      enabled = true,
      weight_adjust = 2,
    },
    buffers = {
      enabled = true,
      weight_adjust = -1,
    }
  },
}

return {
  "ms-jpq/coq_nvim",
  enabled = true,
  branch = 'coq',
  config = function()
  end
}
