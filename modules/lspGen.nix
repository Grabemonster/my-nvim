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
lspTexts = builtins.map (lsp: lspConfigTemplate lsp)
    (builtins.filter (lsp: builtins.hasAttr lsp lspNameMap) lspServers);

  resultText = builtins.concatStringsSep "\n\n" lspTexts;

in

pkgs.writeTextFile {
  name = "lsp_config.lua";
  text = resultText;
}
