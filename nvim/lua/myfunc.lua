local M = {}

function M.key(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.exec_all(dir)
  for _, file in ipairs(
    vim.fn.glob('~/.config/nvim/lua/' .. dir .. '/*.lua', 0, 1)
  ) do
    local ok, _ = pcall(require, dir .. '/' .. vim.fn.fnamemodify(file, ':t:r'))
    if not ok then
      print(string.format("Cannot execute %s", dir))
    end
  end
end

function M.today(fmt)
  return vim.fn.strftime(fmt)
end

return M
