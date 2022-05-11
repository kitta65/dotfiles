local group
local cmds

-- common
group = vim.api.nvim_create_augroup("common", {})
vim.api.nvim_create_autocmd({"FileType"}, {
  group = group,
  pattern = {'*'},
  command = [[syntax sync minlines=10000]]
})

-- bigquery
group = vim.api.nvim_create_augroup("bigquery", {})
cmds = {
  [[setlocal foldmethod=indent]],
}
for _, cmd in ipairs(cmds) do
  vim.api.nvim_create_autocmd({"FileType"}, {
    group = group,
    pattern = {'bigquery'},
    command = cmd
  })
end

-- vim
group = vim.api.nvim_create_augroup("vim", {})
cmds = {
  [[setlocal foldmethod=marker]],
  [[iabbrev <buffer> == ==#]],
  -- do not quote!
  [[inoremap <buffer> "<space> "<space>]]
}
for _, cmd in ipairs(cmds) do
  vim.api.nvim_create_autocmd({"FileType"}, {
    group = group,
    pattern = {'vim'},
    command = cmd
  })
end

-- go
group = vim.api.nvim_create_augroup("go", {})
vim.api.nvim_create_autocmd({"FileType"}, {
  group = group,
  pattern = {'go'},
  command = [[setlocal noexpandtab]]
})

-- markdown
group = vim.api.nvim_create_augroup("markdown", {})
cmds = {
  [[setlocal conceallevel=1]],
  [[setlocal concealcursor=]],
  -- overwrite markdwonUrl
  [[syntax match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained conceal cchar=∞]]
}
for _, cmd in ipairs(cmds) do
  vim.api.nvim_create_autocmd({"FileType"}, {
    group = group,
    pattern = {'markdown'},
    command = cmd
  })
end
