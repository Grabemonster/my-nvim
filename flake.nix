{
    description = "Nvim Flake mit Lua Config, Nerd Font und Luarocks";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    };

    outputs = { self, nixpkgs, home-manager, ... }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };
    in {
        # Paket: nvim + auto-verlinkung + luarocks + Nerd Font
        homeManagerModules.my-nvim = import ./modules/my-nvim.nix;

    };
}
