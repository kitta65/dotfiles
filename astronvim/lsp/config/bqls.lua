return {
  cmd = { 'bq-language-server', '--stdio' },
  filetypes = { 'sql' },
  root_dir = function() return vim.fn.getcwd() end,
  settings = { bqExtensionVSCode = {} },
}
