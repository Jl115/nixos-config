{ agenix, config, pkgs, ... }:

let user = "jldev"; in

{

  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
     agenix.darwinModules.default
  ];

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;

    settings = {
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs; [
    agenix.packages."${pkgs.system}".default
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  system = {
    checks.verifyNixPath = false;
    primaryUser = user;
    stateVersion = 5;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 1;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;

        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleIconAppearanceTheme = "ClearDark";
        AppleInterfaceStyle = "Dark";
        AppleShowAllFiles = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "right";
        tilesize = 6;
        appswitcher-all-displays = true;
        autohide-delay = 0.15;
        largesize = 64;
        magnification = true;
        mru-spaces = false;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
        ShowStatusBar = true;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
        # NewWindowTargetPath = "file://${config.home.homeDirectory}";
        FXPreferredViewStyle = "Nlsv"; # icnv, clmv, Flwv, Nlsv
        AppleShowAllFiles = true; # show hidden files
      };

      trackpad = {
        Clicking = false;
        Dragging = false;
        FirstClickThreshold = 2;
        SecondClickThreshold = 2;
        TrackpadRightClick = true;
      };
    };
  };
}
