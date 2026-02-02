vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#070722", -- Default Background
  base01 = "#11112d", -- Lighter Background (status bars)
  base02 = "#17173c", -- Selection Background
  base03 = "#4e4ec2", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#7c80b4", -- Dark Foreground (status bars)
  base05 = "#f3edf7", -- Default Foreground
  base06 = "#f3edf7", -- Light Foreground
  base07 = "#f3edf7", -- Lightest Foreground
  -- Accent colors
  base08 = "#fd4663", -- Variables, XML Tags, Errors
  base09 = "#9bfece", -- Integers, Constants
  base0A = "#a9aefe", -- Classes, Search Background
  base0B = "#fff59b", -- Strings, Diff Inserted
  base0C = "#81fec1", -- Regex, Escape Chars
  base0D = "#fff280", -- Functions, Methods
  base0E = "#8188fe", -- Keywords, Storage
  --base0F = '#900017', -- Deprecated, Embedded Tags
})

local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    vim.cmd("hi clear")
    vim.cmd("colorscheme matugen")
  end)
)
