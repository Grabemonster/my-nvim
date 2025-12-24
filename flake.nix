{
  description = "Neovim FHS environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.nvim-env =
      import ./default.nix { inherit pkgs; };

    # Optional but very useful
    apps.${system}.nvim = {
      type = "app";
      program = "${self.packages.${system}.nvim-env}/bin/nvim";
    };

    devShells.${system}.default =
      pkgs.mkShell {
        buildInputs = [ self.packages.${system}.nvim-env ];
        shellHook = ''
        exec ${self.packages.${system}.nvim-env}/bin/nvim-env "$@"
      '';
      };
  };
}
