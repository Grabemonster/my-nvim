{lib, pkgs, nvim_pkgs,  ...}:
    with lib; 
    {
        options.programs.my-nvim = {
            enable = mkEnableOption "My custom Neovim setup";

            package = mkOption {
                type = types.package;
                default = pkgs.neovim;
                description = "Which Neovim package to use";
            };

            viAlias = mkOption {
                type = types.bool;
                default = false;
                description = "setung an vi Allias";
            };
            vimAlias = mkOption {
                type = types.bool;
                default = false;
                description = "setung an vim Allias";
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


