vim.cmd("hi clear")
require("base16-colorscheme").setup({
  -- Background tones
  base00 = "#181212", -- Default Background
  base01 = "#241e1e", -- Lighter Background (status bars)
  base02 = "#2f2828", -- Selection Background
  base03 = "#a08c8b", -- Comments, Invisibles
  -- Foreground tones
  base04 = "#d7c1c1", -- Dark Foreground (status bars)
  base05 = "#ece0df", -- Default Foreground
  base06 = "#ece0df", -- Light Foreground
  base07 = "#ece0df", -- Lightest Foreground
  -- Accent colors
  base08 = "#ffb4ab", -- Variables, XML Tags, Errors
  base09 = "#e4c18d", -- Integers, Constants
  base0A = "#e6bdbc", -- Classes, Search Background
  base0B = "#ffb3b2", -- Strings, Diff Inserted
  base0C = "#e4c18d", -- Regex, Escape Chars
  base0D = "#ffb3b2", -- Functions, Methods
  base0E = "#e6bdbc", -- Keywords, Storage
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
