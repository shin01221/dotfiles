vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#222222", -- Default Background
  base01 = "#2a2a2a", -- Lighter Background (status bars)
  base02 = "#343434", -- Selection Background
  base03 = "#6c6c6c", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#c9a554", -- Dark Foreground (status bars)
  base05 = "#c2c2b0", -- Default Foreground
  base06 = "#c2c2b0", -- Light Foreground
  base07 = "#c2c2b0", -- Lightest Foreground
  -- Accent colors
  base08 = "#b36d43", -- Variables, XML Tags, Errors
  base09 = "#bb7744", -- Integers, Constants
  base0A = "#b36d43", -- Classes, Search Background
  base0B = "#c9a554", -- Strings, Diff Inserted
  base0C = "#e9b996", -- Regex, Escape Chars
  base0D = "#e9cf96", -- Functions, Methods
  base0E = "#e9b596", -- Keywords, Storage
  --base0F = '#3d200f', -- Deprecated, Embedded Tags
})

local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    vim.cmd("hi clear")
    vim.cmd("colorscheme matugen")
  end)
)
