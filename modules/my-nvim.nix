{config, pkgs, lib, my-nvim, ...}:
    with lib;
    let
    cfg = config.programs.my-nvim;
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
            home.file.".config/nvim/init.lua".source = ../init.lua;
            home.file.".config/nvim/lua".source = ../lua;

            programs.bash.shellAliases = mkMerge [
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


