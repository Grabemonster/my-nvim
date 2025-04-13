{
  description = "Nvim Flake mit Lua Config, Nerd Font und Luarocks";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    # Paket: nvim + auto-verlinkung + luarocks + Nerd Font
    packages.${system}.my-nvim = pkgs.writeShellApplication {
      name = "my-nvim";

      runtimeInputs = [
        pkgs.neovim
        pkgs.luarocks
        pkgs.nerd-fonts.droid-sans-mono
        pkgs.fzf
        pkgs.lua5_1
        pkgs.gnugrep
      ];

      text = ''
        CONFIG_DIR="$HOME/.config/nvim"
        mkdir -p "$CONFIG_DIR"
        ln -sf "${self}/init.lua" "$CONFIG_DIR/init.lua"
        ln -sfn "${self}/lua" "$CONFIG_DIR/lua"

        echo "✅ Lua Config verlinkt nach $CONFIG_DIR"
        echo "✅ Luarocks ist verfügbar als: luarocks"

        exec nvim "$@"
      '';
    };
  };
}
