{config, pkgs, lib, my-nvim, ...}:
with lib;
let
    cfg = config.programs.my-nvim;
    # LSP-Dateien einbinden
    lspOverrides = import ./lspGen.nix {
        inherit pkgs;
        lspServers = [
            "lua-language-server"
            "rust-analyzer"
            "pyright"
        ];
    };
in 
    { 
    options.programs.my-nvim = {
        enable = mkEnableOption "My custom Neovim setup";
        package = lib.mkOption {
            type = types.package;
            default = pkgs.neovim;
            description = "Neovim package to use";
        };
        viAlias = mkOption {
            type = types.bool;
            default = false;
            description = "sets an vi Allias";
        };
        vimAlias = mkOption {
            type = types.bool;
            default = false;
            description = "sets an vim Allias";
        };

        aliasName = mkOption {
            type = types.str;
            default = "my-nvim";
            description = "Alias name to run Neovim";
        }; 
    };

    config = mkIf cfg.enable {
        home.packages = [ my-nvim ];
        home.file = lib.mkMerge [
            {
                ".config/nvim/init.lua".source = ../init.lua;
                ".config/nvim/lua".source = ../lua;
            }
            lspOverrides
        ]; 
        


        programs.bash.shellAliases = mkMerge [
            {
                nvim = "${my-nvim}/bin/my-nvim";
            }
            {
                ${cfg.aliasName} = "${my-nvim}/bin/my-nvim";
            }
            (mkIf cfg.viAlias {
                vi = "${my-nvim}/bin/my-nvim";
            })
            (mkIf cfg.vimAlias {
                vim = "${my-nvim}/bin/my-nvim";
            })
        ];
        programs.zsh.shellAliases = mkMerge [
            {
                nvim = "${my-nvim}/bin/my-nvim";
            }
            {
                ${cfg.aliasName} = "${my-nvim}/bin/my-nvim";
            }
            (mkIf cfg.viAlias {
                vi = "${my-nvim}/bin/my-nvim";
            })
            (mkIf cfg.vimAlias {
                vim = "${my-nvim}/bin/my-nvim";
            })
        ];
    };
}


