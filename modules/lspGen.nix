{ pkgs, ... }:
let
    lspList = [
        { name = "lua-language-server";         lspconfigName = "lua_ls";}
        { name = "pyright";                     lspconfigName = "pyright";}
        { name = "nixd";                        lspconfigName = "nixd";}
        { name = "bash-language-server";        lspconfigName = "bashls";}
        { name = "typescript-language-server";  lspconfigName = "ts_ls";}
        { name = "vscode-langservers-extracted";lspconfigName = "cssls";}
        { name = "vscode-langservers-extracted";lspconfigName = "html";}
        { name = "vscode-langservers-extracted";lspconfigName = "jsonls";}
        { name = "vscode-langservers-extracted";lspconfigName = "eslint";}
        { name = "phpactor";                    lspconfigName = "phpactor";}
        { name = "java-language-server";        lspconfigName = "java-language-server";}
        { name = "arduino-language-server";     lspconfigName = "arduino-language-server";}
    ];

    lspConfigTemplate = lsp: ''
        require("lspconfig").['${lsp.lspconfigName}'].setup({ 
            cmd = create_cmd("${pkgs.${lsp.name}}/bin/", "${lsp.lspconfigName}"),
        })
    '';

    configBody = builtins.concatStringsSep "\n" (builtins.map lspConfigTemplate lspList);

    resultText = ''
    return {
        "neovim/nvim-lspconfig",
        config = function()
            local function get_cmd_for_lsp(lspconfigName)
                -- Erstelle den Pfad zur lsp-Konfigurationsdatei für das angegebene lspconfigName
                local lsp_file_path = "~/.local/share/nvim/lazy/nvim-lspconfig/lsp/" .. lspconfigName .. ".lua"

                -- Führe den Befehl aus, um den cmd-Wert zu extrahieren
                local cmd_output = vim.fn.system(
                    "cat " .. lsp_file_path ..
                    " | ${pkgs.gnugrep}/bin/grep 'cmd = { '" ..
                    " | ${pkgs.coreutils}/bin/cut -f 5- -d ' '" ..
                    " | ${pkgs.gnused}/bin/sed -E 's/.*cmd = (.*)/\\1/'" ..
                    " | ${pkgs.perl}/bin/perl -pe 's/^\\{\\s*(.*?)\\s*\\},?$/\\1/' " ..
                    " | ${pkgs.gnused}/bin/sed -E \"s/'/ /g\"" ..
                    " | ${pkgs.coreutils}/bin/tr -d '[:space:]'"
                ) 

                -- Entferne führende und abschließende Leerzeichen oder Zeilenumbrüche und gebe den Wert als Array zurück
                local cmd_parts = vim.split(vim.fn.trim(cmd_output), ",")

                -- Rückgabe als Array
                return cmd_parts
            end

            -- Funktion zum Erstellen des vollständigen cmd-Arrays
            local function create_cmd(base_cmd, lspconfig_name)
                local cmd_parts = {}

                -- Holen des Array aus get_cmd_for_lsp
                local lsp_cmd_parts = get_cmd_for_lsp(lspconfig_name)
    
                -- Füge den Basisbefehl zum ersten Element hinzu
                for i, part in ipairs(lsp_cmd_parts) do
                    if i == 1 then
                        table.insert(cmd_parts, base_cmd .. part)
                    else
                        table.insert(cmd_parts, part)
                    end
                end

                return cmd_parts
            end

        ${configBody}

      end,
    }
    '';

in

    pkgs.writeTextFile {
        name = "lsp_config.lua";
        text = resultText;
    }
