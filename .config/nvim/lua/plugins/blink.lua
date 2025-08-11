return {
  "saghen/blink.cmp",
  dependencies = {
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
  },
  opts = {
    -- cmdline = {
    --   sources = function()
    --     local type = vim.fn.getcmdtype()
    --     if type == "/" or type == "?" then
    --       return { "buffer" }
    --     end
    --     if type == ":" then
    --       return { "cmdline" }
    --     end
    --     return {}
    --   end,
    -- },
    -- completion = {
    --   menu = {
    --     border = "single",
    --   },
    --   documentation = {
    --     auto_show = true,
    --     window = {
    --       border = "single",
    --     },
    -- },
    -- Displays a preview of the selected item on the current line
    -- ghost_text = {
    -- enabled = true,
    -- },
    -- },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "emoji" },
      providers = {
        -- lsp = {
        --   name = "lsp",
        --   enabled = true,
        --   module = "blink.cmp.sources.lsp",
        --   kind = "LSP",
        --   min_keyword_length = 2,
        --   -- When linking markdown notes, I would get snippets and text in the
        --   -- suggestions, I want those to show only if there are no LSP
        --   -- suggestions
        --   --
        --   -- Enabled fallbacks as this seems to be working now
        --   -- Disabling fallbacks as my snippets wouldn't show up when editing
        --   -- lua files
        --   -- fallbacks = { "snippets", "buffer" },
        --   score_offset = 100, -- the higher the number, the higher the priority
        -- },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          -- When typing a path, I would get snippets and text in the
          -- suggestions, I want those to show only if there are no path
          -- suggestions
          fallbacks = { "snippets", "buffer" },
          min_keyword_length = 2,
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          -- min_keyword_length = 4,
          score_offset = 15, -- the higher the number, the higher the priority
        },
        -- snippets = {
        --   name = "snippets",
        --   enabled = true,
        --   max_items = 15,
        --   min_keyword_length = 2,
        --   module = "blink.cmp.sources.snippets",
        --   score_offset = 85, -- the higher the number, the higher the priority
        --   -- Only show snippets if I type the trigger_text characters, so
        --   -- to expand the "bash" snippet, if the trigger_text is ";" I have to
        -- },
        -- Example on how to configure dadbod found in the main repo
        -- https://github.com/kristijanhusak/vim-dadbod-completion
        -- https://github.com/moyiz/blink-emoji.nvim
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 93, -- the higher the number, the higher the priority
          min_keyword_length = 2,
          opts = { insert = true }, -- Insert emoji (default) or complete its name
        },
      },
    },
    snippets = {
      preset = "luasnip",
      -- This comes from the luasnip extra, if you don't add it, won't be able to
      -- jump forward or backward in luasnip snippets
      -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },
    keymap = {
      preset = "default",
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      -- ["<S-k>"] = { "scroll_documentation_up", "fallback" },
      -- ["<S-j>"] = { "scroll_documentation_down", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    },
  },
}
