vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#181211", -- Default Background
  base01 = "#251e1d", -- Lighter Background (status bars)
  base02 = "#2f2827", -- Selection Background
  base03 = "#a08c89", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#d8c2be", -- Dark Foreground (status bars)
  base05 = "#ede0dd", -- Default Foreground
  base06 = "#ede0dd", -- Light Foreground
  base07 = "#ede0dd", -- Lightest Foreground
  -- Accent colors
  base08 = "#ffb4ab", -- Variables, XML Tags, Errors
  base09 = "#dec48c", -- Integers, Constants
  base0A = "#e7bdb6", -- Classes, Search Background
  base0B = "#ffb4a7", -- Strings, Diff Inserted
  base0C = "#dec48c", -- Regex, Escape Chars
  base0D = "#ffb4a7", -- Functions, Methods
  base0E = "#e7bdb6", -- Keywords, Storage
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
