{ config, pkgs, lib, home-manager, ... }:

let
  user = "jldev";
  # Define the content of your file as a derivation
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    brews = pkgs.callPackage ./brews.nix {};
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    masApps = {
      "goodnotes-ki-notizen-pdf" = 1444383602;
      "pages" = 409201541;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        activation.cleanConflicts = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
          rm -rf $HOME/.config/nvim
          rm -rf $HOME/.config/kitty
          rm -rf $HOME/.config/karabiner.json
          rm -rf $HOME/.hammerspoon
        '';
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
          (lib.mapAttrs (_: value: value // { force = true; }) {
            ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./config/nvim;
            ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink ./config/kitty;
            "./".source = config.lib.file.mkOutOfStoreSymlink ./config/.hammerspoon;
          })
        ];

        stateVersion = "23.11";
      };
      programs = {} // import ../shared/programs.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = true;
      username = user;
      entries = [
        { path = "/System/Applications/Apps.app"; }
        { path = "/System/Applications/System Settings.app"; }
        { path = "/System/Applications/Goodnotes.app"; }
        { path = "/Applications/Arc.app"; }
        { path = "${pkgs.kitty}/Applications/Kitty.app"; }
        {
          path = "${config.users.users.${user}.home}/Downloads";
          section = "others";
          options = "--sort name --display stack";
        }
      ];
    };
  };
}
