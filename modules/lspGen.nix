{ pkgs, ... }:

let
    lspList = [
        { name = "lua-language-server"; lspconfigName = "lua_ls";           lspFileName="lua-language-server";}
        { name = "pyright";             lspconfigName = "pyright";          lspFileName="pyright-langserver";}
        { name = "nixd";                lspconfigName = "nixd";             lspFileName="nixd";}
    ];

    lspConfigTemplate = lsp: ''
  require("lspconfig").${lsp.lspconfigName}.setup({
    cmd = { "${pkgs.${lsp.name}}/bin/${lsp.lspFileName}" },
  })
    '';

    configBody = builtins.concatStringsSep "\n\n" (builtins.map lspConfigTemplate lspList);

    resultText = ''
    return {
      "neovim/nvim-lspconfig",
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
