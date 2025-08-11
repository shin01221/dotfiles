return {
  "akinsho/bufferline.nvim",
  keys = {
    {
      "L",
      function()
        vim.cmd("bnext " .. vim.v.count1)
      end,
      desc = "Next buffer",
    },
    {
      "H",
      function()
        vim.cmd("bprev " .. vim.v.count1)
      end,
      desc = "Previous buffer",
    },
    {
      "]b",
      function()
        vim.cmd("bnext " .. vim.v.count1)
      end,
      desc = "Next buffer",
    },
    {
      "[b",
      function()
        vim.cmd("bprev " .. vim.v.count1)
      end,
      desc = "Previous buffer",
    },
  },
  -- opts = {
  --   options = {
  --     mode = "tabs",
  --     -- separator_style = "slant",
  --     show_buffer_close_icons = false,
  --     show_close_icon = false,
  --   },
  -- },
}
