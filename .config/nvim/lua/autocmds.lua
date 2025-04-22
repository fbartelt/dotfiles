local autocmd = vim.api.nvim_create_autocmd

-- Set indentation for specific filetypes
autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
    vim.opt_local.smartindent = true
  end,
})

autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "72"
  end,
})
