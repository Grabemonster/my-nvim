{ pkgs, ... }:

let
    lspList = [
        { name = "lua-language-server"; lspconfigName = "lua_ls"; }
        { name = "rust-analyzer";       lspconfigName = "rust_analyzer"; }
        { name = "pyright";             lspconfigName = "pyright"; }
        { name = "nixd";                lspconfigName = "nixd";}
    ];

    lspConfigTemplate = lsp: ''
  require("lspconfig").${lsp.lspconfigName}.setup({
    cmd = { "${pkgs.${lsp.name}}/bin/${lsp.name}" },
  })
    '';

    configBody = builtins.concatStringsSep "\n\n" (builtins.map lspConfigTemplate lspList);

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
