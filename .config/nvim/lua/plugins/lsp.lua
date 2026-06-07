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
  -- yamlls: register config with cmd + filetypes, merge settings
  vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    settings = {
      yaml = {
        validate = true,
        completion = true,
        hover = true,
        schemaStore = { enable = true },
        schemas = {
          kubernetes = "k8s-*.yaml",
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
          ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        },
      },
    },
  }),
  vim.lsp.enable("yamlls"),
  vim.lsp.enable("clangd"),
  vim.lsp.config("clangd", {
    capailities = {
      offsetEncoding = { "utf-8", "utf-16" },
      textDocument = {
        completion = {
          editsNearCursor = true,
        },
      },
    },
  }),
}
