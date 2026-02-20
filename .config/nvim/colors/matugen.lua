vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#141312", -- Default Background
  base01 = "#201f1e", -- Lighter Background (status bars)
  base02 = "#2b2a28", -- Selection Background
  base03 = "#949187", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#cac6bb", -- Dark Foreground (status bars)
  base05 = "#e6e2df", -- Default Foreground
  base06 = "#e6e2df", -- Light Foreground
  base07 = "#e6e2df", -- Lightest Foreground
  -- Accent colors
  base08 = "#ffb4ab", -- Variables, XML Tags, Errors
  base09 = "#c1c9bc", -- Integers, Constants
  base0A = "#cac6bc", -- Classes, Search Background
  base0B = "#cbc7b3", -- Strings, Diff Inserted
  base0C = "#c1c9bc", -- Regex, Escape Chars
  base0D = "#cbc7b3", -- Functions, Methods
  base0E = "#cac6bc", -- Keywords, Storage
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
