return {
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<S-CR>",
                    accept_word = "<C-CR>",
                },
                color = {
                    suggestion_color = "#550055",
                    cterm = 244,
                }
            })
        end,
    }
}
