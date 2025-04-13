{
    description = "Nvim Flake mit Lua Config, Nerd Font und Luarocks";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    };

    outputs = { self, nixpkgs, home-manager, ... }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
        nvim_pkgs = with pkgs; [
                neovim
                nodejs_20
                python3
                luarocks
                fzf
                lua5_1
                ripgrep
                gcc
                gnumake
                binutils
                libcxx
                cmake
                cargo
            ];
        my-nvim = pkgs.writeShellApplication {
            name = "my-nvim";

            runtimeInputs = nvim_pkgs;

            text=''
                exec nvim "$@"
                '';
        };
    in {
        # Definiere das Home-Manager Modul
        homeManagerModules.my-nvim = {config, pkgs, system, lib, my-nvim, ...}: 
            import ./modules/my-nvim.nix {
                inherit pkgs nvim_pkgs config my-nvim lib;
            };
    };
}
