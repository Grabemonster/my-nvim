{ pkgs, ... }:
let
    lspList = [
        { name = "lua-language-server"; lspconfigName = "lua_ls";           lspFileName="lua-language-server";}
        { name = "pyright";             lspconfigName = "pyright";          lspFileName="pyright-langserver";}
        { name = "nixd";                lspconfigName = "nixd";             lspFileName="nixd";}
    ];

    lspConfigTemplate = lsp: ''
        local ${lsp.lspconfigName}_cmp = "{ "${pkgs.${lsp.name}}/bin/"get_cmd_for_lsp("${lsp.lspconfigName}")
        require("lspconfig").${lsp.lspconfigName}.setup({ 
            cmd = ${lsp.lspconfigName}_cmp,
        })
    '';

    configBody = builtins.concatStringsSep "\n\n" (builtins.map lspConfigTemplate lspList);

    resultText = ''
    return {
      "neovim/nvim-lspconfig",
      config = function()
            local function get_cmd_for_lsp(lspconfigName)
            -- Erstelle den Pfad zur lsp-Konfigurationsdatei für das angegebene lspconfigName
            local lsp_file_path = "~/.local/share/nvim/lazy/nvim-lspconfig/lsp/" .. lspconfigName .. ".lua"

            -- Führe den Befehl aus, um den cmd-Wert zu extrahieren
            local cmd_output = vim.fn.system("cat " .. lsp_file_path .. " | grep 'cmd = { ' | cut -f 6- -d ' ' | cut -c2-")

            -- Entferne führende und abschließende Leerzeichen oder Zeilenumbrüche
            return vim.fn.trim(cmd_output)
        end 
        ${configBody}
      end
    }
    '';

in

    pkgs.writeTextFile {
        name = "lsp_config.lua";
        text = resultText;
    }
