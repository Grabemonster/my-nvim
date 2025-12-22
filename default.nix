{ pkgs ? import <nixpkgs> {} }:

pkgs.buildFHSEnv {
  name = "nvim-env";

  targetPkgs = pkgs: with pkgs; [
    neovim

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
    export NVIM_APPNAME=nvimtest
    exec ${pkgs.neovim}/bin/nvim "$@"
  '
'';


}
