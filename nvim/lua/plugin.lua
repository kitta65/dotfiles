local group = vim.api.nvim_create_augroup("packer", {})
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  group = group,
  pattern = {vim.fn.expand('%:t')},
  command = 'source <afile> | PackerCompile'
})

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme terafox")
    end
  }
end)
