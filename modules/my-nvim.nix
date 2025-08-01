{config, pkgs, lib, my-nvim, ...}:
with lib;
let
    cfg = config.programs.my-nvim;
    # LSP-Dateien einbinden
    lspOverrides = import ./lspGen.nix {
        inherit pkgs; 
    };
    myBuiltinLua =pkgs.runCommand "nvim-lua-dir" {
        lspConfig = lspOverrides;
    } ''
  mkdir -p $out/plugins/nixos
  cp -r ${../lua}/* $out/
  cp $lspConfig $out/plugins/nixos/lsp_config.lua
    ''; 
    in 
    { 
    options.programs.my-nvim = {
        enable = mkEnableOption "My custom Neovim setup";
        package = lib.mkOption {
            type = types.package;
            default = pkgs.neovim;
            description = "Neovim package to use";
        };
        browser = mkOption {
            type = types.str;
            default = "firefox";
            description = "Browser to use";
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
        
        setEditor = mkOption {
            type = types.bool;
            default = false;
            description = "Set Nvim as default Editor";
        };
    };

    config = mkIf cfg.enable {
        home.packages = [ my-nvim ];
        home.file.".config/nvim/init.lua".source = ../init.lua;
        home.file.".config/nvim/lua".source = myBuiltinLua; 
        #home.file.".config/nvim/package.json".source = ../package.json;
        #home.file.".config/nvim/package-lock.json".source = ../package-lock.json;

        home.sessionVariables = mkIf cfg.setEditor {
            EDITOR = "${my-nvim}/bin/my-nvim";
            VISUAL = "${my-nvim}/bin/my-nvim";
            BROWSER = cfg.browser;
        };


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


