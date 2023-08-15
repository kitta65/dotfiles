local group
local cmds

group = vim.api.nvim_create_augroup("common", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { '*' },
  command = [[syntax sync minlines=10000]]
})

group = vim.api.nvim_create_augroup("sql", {})
cmds = {
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

group = vim.api.nvim_create_augroup("noexpandtab", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { 'go', "make" },
  command = [[setlocal noexpandtab]]
})
