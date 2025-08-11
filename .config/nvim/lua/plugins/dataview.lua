return {
  "7sedam7/perec.nvim",
  enabled = false,
  dependencies = {
    "nvim-telescope/telescope.nvim", -- if Telescope is loaded otherwise, remove from here for faster startup.
    "folke/which-key.nvim", -- optional
  },
  init = function()
    require("perec").setup()
  end,
}
