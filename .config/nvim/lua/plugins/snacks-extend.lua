return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {

    styles = {
      snacks_image = {
        relative = "editor",
        col = -1,
      },
      statuscolumn = { enabled = true },
      input = { enabled = true },
      bigfile = { enabled = true },
    },
    image = {
      enabled = true,
      force = false, -- Display images only if the terminal supports it
      doc = {
        inline = false,
        float = true,
      },
      convert = {
        notify = false,
      },
    },
    scroll = {
      enabled = false,
      -- animate = {
      --   duration = { step = 15, total = 250 },
      --   easing = "linear",
      -- },
      -- -- faster animation when repeating scroll after delay
      -- animate_repeat = {
      --   delay = 100, -- delay in ms before using the repeat animation
      --   duration = { step = 5, total = 50 },
      --   easing = "linear",
      -- },
      -- -- what buffers to animate
      -- filter = function(buf)
      --   return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
      -- end,
    },
    picker = {
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            -- I'm used to scrolling like this in LazyGit
            ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
            ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
