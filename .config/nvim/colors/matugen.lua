vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#232a2e", -- Default Background
  base01 = "#2d353b", -- Lighter Background (status bars)
  base02 = "#363f47", -- Selection Background
  base03 = "#d3c6aa", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#d3c6aa", -- Dark Foreground (status bars)
  base05 = "#859289", -- Default Foreground
  base06 = "#859289", -- Light Foreground
  base07 = "#859289", -- Lightest Foreground
  -- Accent colors
  base08 = "#e67e80", -- Variables, XML Tags, Errors
  base09 = "#9da9a0", -- Integers, Constants
  base0A = "#d3c6aa", -- Classes, Search Background
  base0B = "#d3c6aa", -- Strings, Diff Inserted
  base0C = "#96e9ab", -- Regex, Escape Chars
  base0D = "#e9ce96", -- Functions, Methods
  base0E = "#e9ce96", -- Keywords, Storage
  --base0F = '#a21012', -- Deprecated, Embedded Tags
})

local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    vim.cmd("hi clear")
    vim.cmd("colorscheme matugen")
  end)
)
