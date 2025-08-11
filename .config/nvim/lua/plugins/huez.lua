return {
  "vague2k/huez.nvim",
  enabled = false,
  -- if you want registry related features, uncomment this
  -- import = "huez-manager.import"
  branch = "stable",
  event = "UIEnter",
  config = function()
    require("huez").setup({})
  end,
}
