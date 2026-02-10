vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#0c0c0c", -- Default Background
  base01 = "#1c1c1c", -- Lighter Background (status bars)
  base02 = "#262626", -- Selection Background
  base03 = "#5e5e5e", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#a0a0a0", -- Dark Foreground (status bars)
  base05 = "#ffffff", -- Default Foreground
  base06 = "#ffffff", -- Light Foreground
  base07 = "#ffffff", -- Lightest Foreground
  -- Accent colors
  base08 = "#ff8080", -- Variables, XML Tags, Errors
  base09 = "#fbadff", -- Integers, Constants
  base0A = "#99ffe4", -- Classes, Search Background
  base0B = "#ffc799", -- Strings, Diff Inserted
  base0C = "#f980ff", -- Regex, Escape Chars
  base0D = "#ffb980", -- Functions, Methods
  base0E = "#80ffdd", -- Keywords, Storage
  --base0F = '#cc0000', -- Deprecated, Embedded Tags
})

local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    vim.cmd("hi clear")
    vim.cmd("colorscheme matugen")
  end)
)
