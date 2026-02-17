return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = {
      enabled = true,
      doc = {
        inline = false,
        float = true,
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      layout = "ivy",
    },
  },
  keys = {
    {
      "<leader>fC",
      function()
        Snacks.picker.files({ cwd = vim.fn.expand("~/.config") })
      end,
      desc = "Find ~/.config Files",
    },
  },
}
