{ pkgs, ... }:

let
  lspList = [
  { name = "lua-language-server"; lspconfigName = "lua_ls"; }
  { name = "rust-analyzer";       lspconfigName = "rust_analyzer"; }
  { name = "pyright";             lspconfigName = "pyright"; }
  ];

  lspConfigTemplate = lsp: ''
  require("lspconfig").${lsp.lspconfigName}.setup({
    cmd = { "${pkgs.${lsp.name}}/bin/${lsp.name}" },
  })
'';

  lspTexts = builtins.map lspConfigTemplate lspServers;
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
