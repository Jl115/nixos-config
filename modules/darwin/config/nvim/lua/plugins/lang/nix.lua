return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Nix language server
      rnix = {
        cmd = { "rnix-lsp" },
        filetypes = { "nix" },
        root_dir = require("lspconfig.util").root_pattern(".git", "flake.nix", "shell.nix"),
      },
    },
  },
}
