local is_neovide = vim.g.neovide or false
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.image = opts.image or {}
      opts.image.enabled = not is_neovide
    end,
  },
}
