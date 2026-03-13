return {
  "supermaven-inc/supermaven-nvim",
  opts = {
    -- disable for certain filetypes
    -- condition = function()
    --     return string.match(vim.fn.expand("%:t"), "foo.sh")
    -- end,
    keymaps = {
      accept_suggestion = "<Tab>",
      clear_suggestion = "<M-]>",
      accept_word = "<M-y>",
    },
  },
}
