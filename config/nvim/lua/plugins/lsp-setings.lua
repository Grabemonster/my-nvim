return {
    {
        "neovim/nvim-lspconfig",
        vim.lsp.config("pyright", {
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "workspace",
                        extraPaths = { vim.fn.getenv("PYTHONPATH") },
                    },
                },
            },
        })
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "mason.nvim",
            "nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup()
        end,
    }
}

