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
        { name = "texlab";                      lspconfigName = "texlab";}

    ];

    lspConfigTemplate = lsp: ''
        vim.lsp.config("${lsp.lspconfigName}",{
            cmd = create_cmd("${pkgs.${lsp.name}}/bin/", "${lsp.lspconfigName}"),
        })
        vim.lsp.enable("${lsp.lspconfigName}")
    '';

    configBody = builtins.concatStringsSep "\n" (builtins.map lspConfigTemplate lspList);

    resultText = ''
    return {
        "neovim/nvim-lspconfig",
        config = function()
            local function get_default_cmd(name)
  -- Neuer Weg (kommt mit nvim-lspconfig ≥ 3.0.0)
  if vim.lsp.get_configs then
    local cfgs = vim.lsp.get_configs()
    if cfgs and cfgs[name] and cfgs[name].cmd then
      return vim.deepcopy(cfgs[name].cmd)
    end
  end

  -- Alter Weg (heute)
  local ok, lspconfig = pcall(require, "lspconfig")
  if ok and lspconfig[name] and lspconfig[name].document_config then
    return vim.deepcopy(lspconfig[name].document_config.default_config.cmd)
  end

  return nil
end
            local function create_cmd(base_cmd, lspconfig_name)
                local default_cmd = get_default_cmd(lspconfig_name)
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
