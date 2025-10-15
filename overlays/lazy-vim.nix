self: super: with super; {

  lazyvim-install = stdenv.mkDerivation {
    pname = "lazyvim-install";
    version = "1.0";

    src = fetchFromGitHub {
      owner = "LazyVim";
      repo = "starter";
      rev = "HEAD";
      sha256 = lib.fakeSha256; # Replace with real hash after first build
    };

    installPhase = ''
      mkdir -p $out/share/lazyvim
      cp -r ./* $out/share/lazyvim/
    '';

    meta = with lib; {
      description = "Pre-cloned LazyVim starter configuration for Neovim";
      homepage = "https://github.com/LazyVim/starter";
      license = licenses.mit;
      platforms = platforms.all;
    };
  };

}
