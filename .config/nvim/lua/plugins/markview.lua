return {

  enabled = false,
  "OXY2DEV/markview.nvim",
  lazy = true, -- Recommended
  ft = "markdown", -- If you decide to lazy-load anyway

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    local ok, presets = pcall(require, "markview.presets")
    if not ok then
      vim.notify("Failed to load markview.presets", vim.log.levels.ERROR)
      return
    end
    -- Setup Markview with preset headings
    require("markview").setup({
      markdown = {
        headings = presets.headings.slanted, -- Use the glow preset
        tables = presets.tables.rounded,
        list_items = { shift_width = 2, indent_size = 1 },
      },
    })
    require("markview").setup(opts)
    Snacks.toggle({
      name = "Markview",
      get = function()
        return vim.g.markview_enabled == true
      end,
      set = function(enabled)
        if enabled then
          vim.cmd("Markview toggle")
          vim.g.markview_enabled = true
        else
          vim.cmd("Markview toggle")
          vim.g.markview_enabled = false
        end
      end,
    }):map("<leader>um")
    -- Try requiring markview.presets
  end,
}
