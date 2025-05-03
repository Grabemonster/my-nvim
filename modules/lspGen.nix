{ pkgs, ... }:
let
    lspList = [
        { name = "lua-language-server"; lspconfigName = "lua_ls";           lspFileName="lua-language-server";}
        { name = "pyright";             lspconfigName = "pyright";          lspFileName="pyright-langserver";}
        { name = "nixd";                lspconfigName = "nixd";             lspFileName="nixd";}
    ];

    lspConfigTemplate = lsp: ''
        local ${lsp.lspconfigName}_base_cmf = "{ '${pkgs.${lsp.name}}/bin/'"
        local ${lsp.lspconfigName}_cmd = {}
        -- Füge die Teile von get_cmd_for_lsp hinzu, aber überspringe den ersten Teil, der bereits im Pfad enthalten ist
        for i, part in ipairs(get_cmd_for_lsp("lua_ls")) do
            -- Füge alle weiteren Teile nach dem ersten hinzu
            if i > 1 then
                table.insert(${lsp.lspconfigName}_cmd, part)
            elseif i==1 then
                table.insert(${lsp.lspconfigName}_cmd, ${lsp.lspconfigName}_base_cmp .. part)
            end
        end
        vim.notify(vim.inspect(${lsp.lspconfigName}_cmd))
        require("lspconfig").${lsp.lspconfigName}.setup({ 
            cmd = ${lsp.lspconfigName}_cmd,
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
            local cmd_output = vim.fn.system("cat " .. lsp_file_path .. " | grep 'cmd = { ' | cut -f 5- -d ' '")

            -- Entferne führende und abschließende Leerzeichen oder Zeilenumbrüche und gebe den Wert als Array zurück
            local cmd_parts = vim.split(vim.fn.trim(cmd_output), ",")
      
            -- Rückgabe als Array
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
