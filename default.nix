{ pkgs, user ? null, ... }:

pkgs.buildFHSEnv {
  name = "nvim-env";

  extraBwrapArgs =
  if user != null then
    [ "--bind" "${./nvim}" "/home/${user}/.config/nvim" ]
  else
    [ "--bind" "${./nvim}" "$HOME/.config/nvim" ];

  targetPkgs = pkgs: with pkgs; [
    nodejs
    python3
    python3Packages.pip
    cargo
    rustc
    go
    gcc
    gnumake
    pkg-config

    curl
    gnugrep
    git
    unzip
    coreutils
    bash
  ];

  

runScript = ''
   bash -c '
    export NVIM_APPNAME=nvim
    exec ${pkgs.neovim}/bin/nvim "$@"
  '
'';


}
