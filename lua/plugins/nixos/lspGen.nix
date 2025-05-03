{ config, pkgs, ... }:

let
  # Liste der LSPs, die du verwenden möchtest
  lspServers = [
    "lua-language-server"
    "rust-analyzer"
    "pyright"
  ];

  # Allgemeine LSP-Konfiguration
  lspConfigTemplate = ''
    return {
      cmd = { "${pkgs.${lspName}}/bin/${lspName}" }; 
    }
  '';

  # Dynamisch LSP-Konfig-Dateien erstellen
  lspConfigs = pkgs.lib.mapAttrs' (nixName: luaName:
    pkgs.lib.nameValuePair
      (".config/nvim/lua/plugins/nixos/${luaName}.lua")
      {
        text = builtins.replaceStrings
          ["${lspName}"]
          [lspName]
          lspConfigTemplate;
      }
  ) (pkgs.lib.filterAttrs (k: _: builtins.elem k lspServers) lspNameMap);

in {
  home.file = lspConfigs;
}

