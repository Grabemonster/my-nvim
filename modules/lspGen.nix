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
        { name = "jdt-language-server";        lspconfigName = "jdtls";} 
        { name = "clang-tools";                 lspconfigName = "clangd";}
        { name = "sqls";                        lspconfigName = "sqlls";}

    ];

    lspConfigTemplate = lsp: ''
        require("lspconfig")["${lsp.lspconfigName}"].setup({
            cmd = create_cmd("${pkgs.${lsp.name}}/bin/", "${lsp.lspconfigName}"),
        })
    '';

    configBody = builtins.concatStringsSep "\n" (builtins.map lspConfigTemplate lspList);

    resultText = ''
    return {
        "neovim/nvim-lspconfig",
        config = function()
            local function get_cmd_for_lsp(lspconfigName)
                local lspconfig = require('lspconfig')
                if lspconfig[lspconfigName] then
                    return lspconfig[lspconfigName].document_config.default_config.cmd
                else
                    return nil 
                end
            end
            local function create_cmd(base_cmd, lspconfig_name)
                local default_cmd = get_cmd_for_lsp(lspconfig_name)
                if default_cmd then
                    local cmd = {}
                    for i, part in ipairs(default_cmd) do
                        if i == 1 then
                            table.insert(cmd, base_cmd .. part)
                        else
                            table.insert(cmd, part)
                        end
                    end
                return cmd
            end
    return {}
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
