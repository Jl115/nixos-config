{ pkgs }:

with pkgs; [
  # Core System & Shell Utilities
  # Essential command-line tools for system management and an enhanced shell experience.
  bash-completion
  bat # A cat(1) clone with wings.
  btop # Modern and feature-rich resource monitor.
  coreutils
  htop # Interactive process viewer.
  killall
  openssh
  tree
  unrar
  unzip
  wget
  zip
  zsh
  zsh-powerlevel10k
  zoxide # A smarter cd command.

  # ---

  # Common Development & CLI Tools
  # A curated list of high-level tools for development workflows.
  age # Simple, modern, and secure file encryption.
  age-plugin-yubikey
  awscli # Official command line tool for AWS.
  curl
  direnv # Environment switcher for the shell.
  fd # A simple, fast and user-friendly alternative to 'find'.
  fzf # A command-line fuzzy finder.
  gh # GitHub's official command line tool.
  git
  git-lfs
  gitleaks # Scans git repos for secrets.
  gnupg
  jq # Command-line JSON processor.
  kubectl # Kubernetes command-line tool.
  lazygit # A simple terminal UI for git commands.
  ripgrep # A line-oriented search tool that recursively searches your current directory for a regex pattern.
  sqlite
  terraform
  kanata # Keyboard customizer.
  neovim
  # ---

  # Containerization
  # Tools for creating and managing containers.
  docker
  docker-compose

  # ---

  # AI Tools
  # Tools related to artificial intelligence.
  aider-chat # AI pair programming in your terminal.
  
  # ---

  # Fonts & Media
  # A collection of popular programming fonts, icon packs, and media tools.
  dejavu_fonts
  ffmpeg
  font-awesome
  graphviz
  hack-font
  imagemagick
  jetbrains-mono
  meslo-lgs-nf
  noto-fonts
  noto-fonts-emoji
  tesseract # OCR engine.

  # ---

  # Scripting Runtimes
  # General-purpose Python for system scripting and tooling.
  python3
  virtualenv
]
