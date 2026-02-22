vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#141311", -- Default Background
  base01 = "#211f1d", -- Lighter Background (status bars)
  base02 = "#2b2a28", -- Selection Background
  base03 = "#959085", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#ccc6ba", -- Dark Foreground (status bars)
  base05 = "#e6e2de", -- Default Foreground
  base06 = "#e6e2de", -- Light Foreground
  base07 = "#e6e2de", -- Lightest Foreground
  -- Accent colors
  base08 = "#ffb4ab", -- Variables, XML Tags, Errors
  base09 = "#c0cab6", -- Integers, Constants
  base0A = "#ccc6b9", -- Classes, Search Background
  base0B = "#cfc6ac", -- Strings, Diff Inserted
  base0C = "#c0cab6", -- Regex, Escape Chars
  base0D = "#cfc6ac", -- Functions, Methods
  base0E = "#ccc6b9", -- Keywords, Storage
  --base0F = '#93000a', -- Deprecated, Embedded Tags
})

local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    vim.cmd("hi clear")
    vim.cmd("colorscheme matugen")
  end)
)
