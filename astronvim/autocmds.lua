local group = vim.api.nvim_create_augroup("sql", {})
local cmds = {
  [[command! BQUpdateCache lua vim.lsp.buf_request(0, "bq/updateCache", nil, function() end)]],
  [[command! BQClearCache lua vim.lsp.buf_request(0, "bq/clearCache", nil, function() end)]],
  [[command! BQDryRun lua vim.lsp.buf_request(0, "bq/dryRun", {uri = "file://" .. vim.fn.expand("%:p")}, function() end)]],
}
for _, cmd in ipairs(cmds) do
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { 'sql' },
    command = cmd
  })
end
