return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconf = require('lspconfig')
        lspconf.pyright.setup({
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "workspace",
                        extraPaths = { vim.fn.getenv("PYTHONPATH") }
                    }
                }
            }
        })
    end,
}
