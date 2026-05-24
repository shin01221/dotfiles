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

  vim.lsp.config("yamlls", {
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    schemas = vim.tbl_extend("force", {
      -- Base schemas from lsp-setup.lua are already included
      kubernetes = "k8s-*.yaml",
      ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
      ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
      ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
      ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
      ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
    }, {}),
  }),
  vim.lsp.enable("djls"),
  vim.lsp.enable("djlsp"),
}
