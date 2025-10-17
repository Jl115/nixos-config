# nixos-config

Opinionated modular flake for macOS (nix-darwin + home-manager) and NixOS. No `nix develop` required—your dev tools are installed system-wide via nix-darwin + Homebrew.

## What you get on macOS

- nix-darwin + home-manager wired with flakes
- Declarative Homebrew (formulae + casks via `nix-homebrew`)
- Dev toolchains preinstalled:
  - Node.js 22, pnpm, yarn, bun, deno
  - Rust (rustup, rustc, cargo, rust-analyzer)
  - Go, gopls, golangci-lint
  - Java (JDK 21), Gradle, Maven
  - Protobuf toolchain (protobuf, buf)
- Editors/Apps via casks: VS Code, Kitty, browsers, Slack, Postman, Docker Desktop, etc.
- Optional Colima runtime (lightweight Docker alternative) via Homebrew formula.
- Zsh + oh-my-zsh + p10k, dotfiles & Neovim config via Home Manager

Folder map: see `modules/darwin/*` and `modules/shared/*`.

## Quick start (macOS)

1) Install Nix (multi-user) and reboot if prompted.
2) Clone this repo:

```zsh
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/Jl115/nixos-config.git
cd nixos-config
```

3) Build & switch to the configuration (Apple Silicon):

```zsh
nix run .#build-switch
```

- On Intel Macs, use:

```zsh
nix run .#x86_64-darwin.build-switch
```

This builds `.#darwinConfigurations.<system>.system` and runs `darwin-rebuild switch` from the build result. It will also install/upgrade Homebrew formulae and casks.

## Common operations

- Build only (no switch):

```zsh
nix run .#build
```

- Roll back to previous generation:

```zsh
nix run .#rollback
```

- Clean build artifacts:

```zsh
nix run .#clean
```

## Where to add tools

- Nix packages shared between macOS/Linux: `modules/shared/packages.nix`
- macOS-only Nix packages: `modules/darwin/packages.nix`
- Homebrew formulae: `modules/darwin/brews.nix`
- Homebrew casks (GUI apps): `modules/darwin/casks.nix`

Change lists, then run `nix run .#build-switch` to apply.

## Containers on macOS

- Docker Desktop is managed via casks
- Colima is installed via brew and can be used as a local Docker runtime:

```zsh
colima start
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock
```

## Notes

- Some first-time runs may prompt for permissions (e.g., wallpaper change via AppleScript, Homebrew xcode-select tools).
- Secrets are optional; see `modules/darwin/secrets.nix` and the `secrets` flake input in `flake.nix` if you use agenix.
- If you need a different macOS hostname, add `networking.hostName` under `hosts/darwin/default.nix`.

---

If you want to make the setup even more specific to your workflow, tell me which extra tools you need and I'll wire them in.
