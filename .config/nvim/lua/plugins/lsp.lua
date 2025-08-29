return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {},
        pyright = {
          settings = {
            python = {
              pythonPath = "/usr/bin/python3.13", -- Change this if needed
            },
          },
        },
      },
    },
  },
}
