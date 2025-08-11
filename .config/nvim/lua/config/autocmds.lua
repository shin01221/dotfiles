-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.linebreak = false -- Prevents soft wrapping at word boundaries
  end,
})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.md",
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })

-- Disable autoformat only for JSON files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "jsonc,json" },
  callback = function()
    vim.b.autoformat = false
  end,
})
-- -- to be deleted or optimized
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.md",
--   callback = function()
--     vim.opt_local.concealcursor = ""
--     vim.opt_local.conceallevel = 2
--   end,
-- })
