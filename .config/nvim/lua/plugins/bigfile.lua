---@type LazySpec
return {
  "LunarVim/bigfile.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    filesize = 1, -- 1MB limit for "big" files
    features = {
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
    },
    hooks = {
      disable = function()
        -- Disable plugins explicitly using LazyVim's `require` method
        local plugins_to_disable = {
          "blink-cmp-dictionary",
          "blink-emoji.nvim",
          "blink.cmp",
          "bufferline.nvim",
          "clangd_extensions.nvim",
          "flash.nvim",
          "friendly-snippets",
          "img-clip.nvim",
          "LuaSnip",
          "mason-lspconfig.nvim",
          "mason.nvim",
          "mini.ai",
          "mini.animate",
          "mini.hipatterns",
          "mini.indentscope",
          "mini.pairs",
          "neocodeium",
          "neoconf.nvim",
          "noice.nvim",
          "nui.nvim",
          "nvim-lint",
          "nvim-treesitter-textobjects",
          "nvim-ts-autotag",
          "nvim-web-devicons",
          "oil.nvim",
          "persistence.nvim",
          "snipe.nvim",
          "telescope.nvim",
          "themery.nvim",
          "tiny-inline-diagnostic.nvim",
          "todo-comments.nvim",
          "ts-comments.nvim",
          "which-key.nvim",
          "yanky.nvim",
          "trouble.nvim", -- Disabled for big files, keep only Lualine
        }

        -- Disable all heavy plugins manually
        for _, plugin in ipairs(plugins_to_disable) do
          vim.g["loaded_" .. plugin] = 1
        end

        -- Disable unnecessary features: Syntax, Treesitter, etc.
        vim.opt_local.syntax = "off"
        vim.opt_local.foldenable = false
        vim.opt_local.cursorline = false
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.colorcolumn = ""
        vim.opt_local.spell = false
        vim.opt_local.signcolumn = "no"

        -- Keep essential plugins
        vim.cmd("LualineToggle") -- Ensure lualine stays active
        vim.cmd("colorscheme ayu") -- Ensure colorscheme remains active

        -- Explicitly ensure snacks.nvim is loaded
        require("lazy").enable("snacks.nvim")

        -- Optional: Show a message when plugins are disabled
        vim.cmd("echohl WarningMsg | echom 'Bigfile detected: Only essential plugins enabled.' | echohl None")
      end,
    },
  },
}
