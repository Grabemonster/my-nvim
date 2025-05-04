return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconf = require('lspconfig') 
        local on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, noremap = true, silent = true }
            pcall(vim.keymap.del("n", "gd", { buffer = bufnr }))
            pcall(vim.keymap.del("n", "df", { buffer = bufnr }))
            pcall(vim.keymap.del("n", "o", { buffer = bufnr }))
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<leader>df", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, opts)
            print("LSP attact")
        end
        lspconf.pyright.setup({
            on_attach = on_attach,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "workspace",
                        extraPaths = { vim.fn.getenv("PYTHONPATH") }
                    }
                }, 
            }
        })
    end,
}
