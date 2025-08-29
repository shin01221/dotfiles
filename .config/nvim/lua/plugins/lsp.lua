return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          -- cmd = {
          --   "qmlls",
          --   "-I",
          --   "/usr/lib/qt6/qml",
          -- },
        },
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
