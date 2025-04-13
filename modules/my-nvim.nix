{config, lib, pkgs, nvim_pkgs,  ...}:
    with lib;
    {
        options.programs.my-nvim = {
            enable = mkEnableOption "My custom Neovim setup";
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
            home.packages = nvim_pkgs;
            home.file.".config/nvim/init.lua".source = ../init.lua;
            home.file.".config/nvim/lua".source = ../lua;

            programs.bash.shellAliases = mkMerge [
                {
                    ${cfg.aliasName} = "nvim";
                }
                (mkIf cfg.viAlias {
                    vi = "nvim";
                })
                (mkIf cfg.vimAlias {
                    vim = "nvim";
                })
            ];
            programs.zsh.shellAliases = mkMerge [
                {
                    ${cfg.aliasName} = "nvim";
                }
                (mkIf cfg.viAlias {
                    vi = "nvim";
                })
                (mkIf cfg.vimAlias {
                    vim = "nvim";
                })
            ];
        };
    }


