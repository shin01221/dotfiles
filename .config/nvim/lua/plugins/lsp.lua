return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
