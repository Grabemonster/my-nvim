return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "vim", "vimdoc", "bash", "python", "json", "html", "css", "javascript", "typescript", "go", "c", "nix", "markdown"
            }, -- Add the languages you want
            highlight = {
                enable = true,              -- Enable syntax highlighting
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,              -- Auto indentation
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm", 
                },
            },
            -- Optional: rainbow brackets, context, etc. can go here too
        })
    end,
}

