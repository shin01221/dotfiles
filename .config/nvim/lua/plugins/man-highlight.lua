return {
  enabled = false,
  "vim-utils/vim-man",
  config = function()
    vim.g.man_hardwrap = 0 -- Disable auto-wrapping for better readability
  end,
}
