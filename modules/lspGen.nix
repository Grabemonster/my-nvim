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

  # Alle LSPs in einer einzigen Konfigurationsdatei
  lspConfig = pkgs.lib.concatMapAttrs' (nixName: luaName: 
    lspConfigTemplate nixName
  ) (pkgs.lib.filterAttrs (k: _: builtins.elem k lspServers) lspNameMap);

in
  # Hier wird die gesamte LSP-Konfiguration als Text in eine einzige Datei geschrieben
  lspConfig

