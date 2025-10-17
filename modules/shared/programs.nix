{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "jl115";
  user = "jldev";
  email = "joelbern006@gmail.com";
in {
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    cdpath = ["~/Projects"];
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "alias-finder"
        "zsh-syntax-highlighting"
        "zsh-autosuggestions"
      ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = "p10k.zsh";
      }
    ];
    initContent = lib.mkBefore ''
       if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
         . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
         . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
       fi




       zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
       zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
       zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
       zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


       # Define variables for directories
       export EDITOR=nvim
       export LANG=en_US.UTF-8
       export NVM_DIR="$HOME/.nvm"
       export PATH=$HOME/.gem/bin:$PATH
       export PATH="$PATH:$HOME/.pub-cache/bin"
       export PATH="$PATH:$(go env GOPATH)/bin"
       export PATH=$HOME/.local/share/bin:$PATH
       export PATH="/usr/local/opt/trash/bin:$PATH"
       export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
       export PATH="$HOME/Development/flutter/bin:$PATH"
       export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
       export PATH="$PATH":"$HOME/Library/Android/sdk/platform-tools"
       export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH





       # Remove history data we don't want to see
       export HISTIGNORE="pwd:ls:cd"

       # aliases
       alias search=rg -p --glob '!node_modules/*'  $@

       # functions
       shell() {
           nix-shell '<nixpkgs>' -A "$1"
       }

       # Function to find an app using the iTunes API and format with jq
       findapp() {
         if [ -z "$1" ]; then
           echo "Usage: findapp <AppName>"
           return 1
         fi
       curl -s "https://itunes.apple.com/search?term=$1&country=us&entity=software&limit=3" | \
       jq '.results[] | {appName: .trackName, id: .trackId, version: .version, developer: .artistName, bundleID: .bundleId}'
       }

       nbuild() {
         cd ~/.config/nixos-config
         nix run .#build
       }

       nswitch() {
         cd ~/.config/nixos-config
         nix run .#build-switch
       }

       vi() { nvim "$@"; }

       lint() {
        base_dir="../"

        # Exclusion pattern
        exclude_pattern=$(printf "! -name %s " "node_modules" ".vscode" ".idea" ".git" "setup")

        # Collect directories
        dirs=$(eval find "$base_dir" -mindepth 1 -maxdepth 1 -type d $exclude_pattern)

        has_errors=false

        # Loop without subshell (use process substitution instead of a pipe)
        while IFS= read -r dir; do
          echo "Processing $dir..."
          if [ -f "$dir/package.json" ]; then
            if grep -q "\"lint\":" "$dir/package.json"; then
              echo "Linting $dir..."
              if npm run lint --prefix "$dir"; then
                echo "Linting succeeded in $dir"
              else
                echo "Linting failed in $dir"
                has_errors=true
              fi
            else
              echo "No lint command found in $dir, skipping."
            fi
          else
            echo "No package.json found in $dir, skipping."
          fi
        done < <(echo "$dirs")

        if [ "$has_errors" = false ]; then
          echo "All linting completed successfully!"
        else
          echo "Linting completed with errors."
        fi
       }
       migration() {
        npx sequelize-cli migration:generate --name "$1"
       }

       # Use difftastic, syntax-aware diffing
       alias diff=difft
       alias flor-dev="ssh centos@dev.app.floriplan.ch"
       alias flor-test="ssh centos@test.app.floriplan.ch"
       alias myev-dev="ssh centos@dev.my.evosys.ch"
       alias myev-test="ssh centos@test.my.evosys.ch"
       alias ahub-dev="ssh debian@dev.app.alarmhub.ch"
       alias ahub-test="ssh debian@test.app.alarmhub.ch"
       alias aldi-dev="ssh debian@dev.app.alarmdisplay.ch"
       alias spot-dev="ssh debian@dev.app.spotpilot.ch"
       alias spot-test="ssh debian@test.app.spotpilot.ch"
       alias aldi-test="ssh debian@test.app.alarmdisplay.ch"
       alias gu="git reset --soft HEAD~1"
       alias vp-log="ssh -p 58291 root@31.97.36.220"
       alias vp-kube="ssh -L 6443:127.0.0.1:6443 root@31.97.36.220 -p 58291"
       alias cd='z'
       alias cdi='zi'
       alias cdl='zoxide query -l -s | less'
       alias cda='zoxide add'
       # Always color ls and group directories
       alias ls='ls --color=auto'
       alias resetDb="npx sequelize db:drop && npx sequelize db:create && npx sequelize db:migrate && npx sequelize db:seed:all"
       alias clear="clear && printf '\e[3J'"

       alias mg="migration"
       alias mgn="migration"
       alias f="fvm flutter"
       alias d="fvm dart"
       alias gu="git reset --soft HEAD~1"
       alias vp-log="ssh -p 58291 root@31.97.36.220"
       alias vp-kube="ssh -L 6443:127.0.0.1:6443 root@31.97.36.220 -p 58291"

        # NVM Initialization
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

        # place this after nvm initialization!
        autoload -U add-zsh-hook

        load-nvmrc() {
          local nvmrc_path
          nvmrc_path="$(nvm_find_nvmrc)"

          if [ -n "$nvmrc_path" ]; then
            local nvmrc_node_version
            nvmrc_node_version=$(nvm version "$(cat "$nvmrc_path")")

            if [ "$nvmrc_node_version" = "N/A" ]; then
              nvm install
            elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
              nvm use
            fi
          elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
            echo "Reverting to nvm default version"
            nvm use default
          fi
        }

        add-zsh-hook chpwd load-nvmrc
        load-nvmrc

       [[ -f /Users/joelevo/.dart-cli-completion/zsh-config.zsh ]] && . /Users/joelevo/.dart-cli-completion/zsh-config.zsh || true
       eval "$(zoxide init zsh)"
    '';
  };

  git = {
    enable = true;
    ignores = ["*.swp"];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey =
        if pkgs.stdenv.hostPlatform.isDarwin
        then "/Users/${user}/.ssh/id_ed25519.pub"
        else "/home/${user}/.ssh/id_ed25519.pub";
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-airline-themes
      vim-startify
    ];
    settings = {
      ignorecase = true;
    };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/Projects',
        \ '~/Documents',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
    '';
  };

  kitty = {
    enable = true;
  };

  fzf = {
    enableBashIntegration = true;
  };

  neovim = {
    enable = true;
    withNodeJs = true;
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux "/home/${user}/.ssh/config_external")
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "/Users/${user}/.ssh/config_external")
    ];
    matchBlocks = {
      "*" = {
        # Set the default values we want to keep
        sendEnv = [
          "LANG"
          "LC_*"
        ];
        hashKnownHosts = true;
      };
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux "/home/${user}/.ssh/id_github")
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "/Users/${user}/.ssh/id_github")
        ];
      };
    };
  };
}
