vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#111111", -- Default Background
  base01 = "#191919", -- Lighter Background (status bars)
  base02 = "#232323", -- Selection Background
  base03 = "#606060", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#5d5d5d", -- Dark Foreground (status bars)
  base05 = "#828282", -- Default Foreground
  base06 = "#828282", -- Light Foreground
  base07 = "#828282", -- Lightest Foreground
  -- Accent colors
  base08 = "#dddddd", -- Variables, XML Tags, Errors
  base09 = "#cccccc", -- Integers, Constants
  base0A = "#a7a7a7", -- Classes, Search Background
  base0B = "#aaaaaa", -- Strings, Diff Inserted
  base0C = "#e99696", -- Regex, Escape Chars
  base0D = "#e99696", -- Functions, Methods
  base0E = "#e99696", -- Keywords, Storage
  --base0F = '#967171', -- Deprecated, Embedded Tags
})

local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    vim.cmd("hi clear")
    vim.cmd("colorscheme matugen")
  end)
)
