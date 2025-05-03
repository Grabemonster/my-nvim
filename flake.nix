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
                lua-language-server
            ];
        my-nvim = pkgs.writeShellApplication {
            name = "my-nvim";

            runtimeInputs = nvim_pkgs;

            text=''
                exec nvim "$@"
                '';
        };

        # Hier definierst du die devShell
        devShell = pkgs.mkShell {
            buildInputs = nvim_pkgs;
            shellHook = ''
        # Setze den NVIM_CONFIG_DIR auf den lokalen Ordner der Flake
                echo $PWD
                export XDG_CONFIG_HOME="$PWD/../"  # Hier auf den lokalen Ordner umstellen
                export NVIM_CONFIG_DIR="$PWD/../"
            '';
        };
     in {
        # Exportiere `my-nvim` unter `packages.${system}.my-nvim`
        packages.${system}.my-nvim = my-nvim;

        # Definiere das Home-Manager Modul und übergebe `my-nvim` als Argument
        homeManagerModules.my-nvim = {config, pkgs, system, lib, ...}: 
            import ./modules/my-nvim.nix {
                inherit pkgs nvim_pkgs config my-nvim lib;
            };
            import ./lua/plugins/nixos/lspGen.nix {
                inherit pkgs config
            }
        # Definiere die devShell als Teil der Ausgaben
        devShells.${system}.my-nvim = devShell;
    };
}
