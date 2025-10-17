return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {

      -- Nix language server (nixd)
      nixd = {
        cmd = { "nixd" },
        filetypes = { "nix" },
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "alejandra" }, -- nixfmt or nixpkgs-fmt also work
            },
            -- Optional: expose flake options to LSP
            options = {
              nixos = {
                expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.hostname.options',
              },
              home_manager = {
                expr = '(builtins.getFlake "/etc/nixos").homeConfigurations.username.options',
              },
            },
          },
        },
      },
    },
  },
}
