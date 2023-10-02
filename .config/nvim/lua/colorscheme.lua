local status, _ = pcall(vim.cmd, "colorscheme industry")

if not status then
  print("Colorscheme not found!") -- Print an error message if the colorscheme is not installed
  return
end
