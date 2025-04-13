{config, lib, pkgs, ...}:
    with lib;
    let
    cfg = config.programs.my-nvim;
    in 
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
        };

        config = mkIf cfg.enable {
            home.packages = with pkgs; [
                cfg.package
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


