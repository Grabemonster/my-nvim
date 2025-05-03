return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconf = require('lspconfig')
        lspconf.pyright.setup({
            settings = {
                python = {
                    analysis = {
                        autoSearchPath = true,
                        useLibaryCodeForTypes = true,
                        diagnosticMode = "workspace",
                        extraPath = { vim.fn.getenv("PYTHONPATH")}
                    }
                }
            }
        })
    end,
}
