return {
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<M-TAB>",
                    accept_word = "<M-w>",
                },
                color = {
                    suggestion_color = "#550055",
                    cterm = 244,
                }
            })
        end,
    }
}
