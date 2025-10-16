{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
# Mac specific packages
shared-packages ++ [
  dockutil
  bartender
]
