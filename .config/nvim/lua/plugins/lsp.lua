vim.g.lazyvim_python_lsp = "basedpyright"

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
      },
    },
  },
  -- vim.lsp.config / vim.lsp.enable calls remain after these plugin specs
  vim.lsp.config("djls", {
    cmd = { "djls", "serve" },
    filetypes = { "htmldjango", "html", "python" },
    root_markers = { "manage.py", "pyproject.toml", ".git" },
  }),

  vim.lsp.config("djlsp", {
    cmd = { "djlsp" },
    filetypes = { "htmldjango", "html" },
    root_markers = { ".git" },
    settings = {},
  }),
  -- vim.lsp.config("basedpyright", {
  --   settings = {
  --     basedpyright = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         diagnosticMode = "openFilesOnly",
  --         autoImportCompletions = true,
  --       },
  --     },
  --   },
  -- }),
  --
  -- vim.lsp.enable("basedpyright"),
  vim.lsp.enable("djls"),
  vim.lsp.enable("djlsp"),
}
