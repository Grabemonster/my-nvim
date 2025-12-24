{ pkgs, user ? null, ... }:
let
config = if user != null then "/home/${user}/.config/nvim" else "$HOME/.config/nvim";
tempfs = "/etc/nvim";

in
pkgs.buildFHSEnv {
  name = "nvim-env";

  extraBwrapArgs = [
  "--dir" "${config}"
  "--tmpfs" "${config}"
  "--dir" "${config}/lua"
  "--ro-bind" "${./nvim}/lua" "${config}/lua" 
  "--ro-bind" "${./nvim}/init.lua" "${config}/init.lua" 
  ];


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
    cp -n ${./nvim}/lazy-lock.json ${config}/lazy-lock.json
    chmod 0666 ${config}/lazy-lock.json

    export NVIM_APPNAME=nvim
    exec ${pkgs.neovim}/bin/nvim "$@"
  '  _ "$@"
'';
}
