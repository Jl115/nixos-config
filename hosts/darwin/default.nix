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

services.aerospace = {
  enable = true;
  package = pkgs.aerospace;

  settings = {
    after-login-command = [ ];
    after-startup-command = [ ];

    enable-normalization-flatten-containers = true;
    enable-normalization-opposite-orientation-for-nested-containers = true;

    accordion-padding = 30;
    default-root-container-layout = "tiles";
    default-root-container-orientation = "auto";

    automatically-unhide-macos-hidden-apps = false;
    key-mapping = {
      preset = "qwerty";

      "cmd-slash" = "layout tiles horizontal vertical";
      "cmd-comma" = "layout accordion horizontal vertical";

      "cmd-h" = "focus left";
      "cmd-j" = "focus down";
      "cmd-k" = "focus up";
      "cmd-l" = "focus right";

      "cmd-shift-h" = "move left";
      "cmd-shift-j" = "move down";
      "cmd-shift-k" = "move up";
      "cmd-shift-l" = "move right";

      "cmd-shift-minus" = "resize smart -50";
      "cmd-shift-equal" = "resize smart +50";

      "cmd-1" = "workspace 1";
      "cmd-2" = "workspace 2";
      "cmd-3" = "workspace 3";
      "cmd-4" = "workspace 4";
      "cmd-5" = "workspace 5";
      "cmd-6" = "workspace 6";
      "cmd-7" = "workspace 7";
      "cmd-8" = "workspace 8";
      "cmd-9" = "workspace 9";

      "cmd-shift-semicolon" = "mode service";
    };

    mode = {
      main = {
        binding = {
          "cmd-r" = "reload-config";
          "cmd-c" = "exec open -a Terminal";
        };
      };

      service = {
        binding = {
          esc = [ "reload-config" "mode main" ];
          r = [ "flatten-workspace-tree" "mode main" ];
          f = [ "layout floating tiling" "mode main" ];
          backspace = [ "close-all-windows-but-current" "mode main" ];

          "cmd-h" = [ "join-with left" "mode main" ];
          "cmd-j" = [ "join-with down" "mode main" ];
          "cmd-k" = [ "join-with up" "mode main" ];
          "cmd-l" = [ "join-with right" "mode main" ];
        };
      };
    };
  };
};
}
