vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#17120f", -- Default Background
  base01 = "#241f1b", -- Lighter Background (status bars)
  base02 = "#2f2925", -- Selection Background
  base03 = "#9e8e82", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#d6c3b6", -- Dark Foreground (status bars)
  base05 = "#ece0da", -- Default Foreground
  base06 = "#ece0da", -- Light Foreground
  base07 = "#ece0da", -- Lightest Foreground
  -- Accent colors
  base08 = "#ffb4ab", -- Variables, XML Tags, Errors
  base09 = "#c4cb97", -- Integers, Constants
  base0A = "#e3c0a5", -- Classes, Search Background
  base0B = "#ffb77a", -- Strings, Diff Inserted
  base0C = "#c4cb97", -- Regex, Escape Chars
  base0D = "#ffb77a", -- Functions, Methods
  base0E = "#e3c0a5", -- Keywords, Storage
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
