{pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSEnv{
    name = "nvim-env";

    targetPkgs = pkgs: (with pkgs; [
        neovim
        # Common LSP tooling dependencies
        nodejs
        python3
        python3Packages.pip
        cargo
        rustc
        go
        gcc
        gnumake
        pkg-config

        # Runtime basics installers often expect
        curl
        gnugrep
        git
        unzip
        coreutils
        bash
    ]);

    runScript = ''
        bash -c 'export NVIM_APPNAME=nvimtest; nvim'
    '';
}).env
