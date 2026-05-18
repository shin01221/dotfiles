return {
  "rachartier/tiny-inline-diagnostic.nvim",
  -- enabled = false,
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({ preset = "modern" })
    vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
  end,
}
