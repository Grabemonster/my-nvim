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
    require("lspconfig").${lspNameMap.${lsp}}.setup({
      cmd = { "${pkgs.${lsp}}/bin/${lsp}" },
    })  '';

  # Liste der aktiven LSPs mit Texten
lspTexts = builtins.map (lsp: lspConfigTemplate lsp)
    (builtins.filter (lsp: builtins.hasAttr lsp lspNameMap) lspServers);

  configBody = builtins.concatStringsSep "\n\n" lspTexts;

  resultText = ''
    return {
      "neovim/lspconfig",
      config = function()
    ${configBody}
      end
    }
  '';

in

pkgs.writeTextFile {
  name = "lsp_config.lua";
  text = resultText;
}
