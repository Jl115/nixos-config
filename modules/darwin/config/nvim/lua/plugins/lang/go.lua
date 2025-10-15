return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            usePlaceholders = true, -- adds placeholders for function parameters
            completeUnimported = true, -- auto-import packages
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true, -- format with gofumpt instead of gofmt
          },
        },
      },
    },
  },
}
