return {
    "neovim/nvim-lspconfig",
    keys = {
        {"<leader>gd", vim.lsp.buf.definition()},
        {"<leader>of", vim.diagnostic.open_float()},
        {"<leader>df", vim.lsp.buf.hover()},
        {"<leader>b", "<C-o>"},
        {"<leader>f", "<C-i>"}
    },
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
