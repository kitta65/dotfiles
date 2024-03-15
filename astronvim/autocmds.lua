vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("common", {}),
  pattern = { '*' },
  command = [[]]
})
