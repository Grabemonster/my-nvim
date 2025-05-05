return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconf = require('lspconfig')
        local lsp_group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = lsp_group,
            callback = function(args)
                local bufnr = args.buf
                local opts = { buffer = bufnr, silent = true }

                -- jump to definition
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

                -- you could put all your other mappings here too:
                -- vim.keymap.set('n', 'K',  vim.lsp.buf.hover,        opts)
                -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                -- ...
            end,
        })

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
