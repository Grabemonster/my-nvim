{ pkgs, ... }:

let
  lspServers = [
    "lua-language-server"
    "rust-analyzer"
    "pyright"
  ];

  lspNameMap = {
    "lua-language-server" = "lua_ls";
    "rust-analyzer" = "rust_analyzer";
    "pyright" = "pyright";
  };

  lspConfigTemplate = lspName: ''
    return {
      cmd = { "${pkgs.${lspName}}/bin/${lspName}" },
    }
  '';

  # Liste der aktiven LSPs mit Texten
  activeLspTexts = builtins.map (lsp:
    lspConfigTemplate lsp
  ) (builtins.filter (lsp: builtins.hasAttr lsp lspNameMap) lspServers);

  # Verbinde alle zu einer einzigen Datei
  lspConfig = builtins.concatStringsSep "\n\n" activeLspTexts;

in
  lspConfig

