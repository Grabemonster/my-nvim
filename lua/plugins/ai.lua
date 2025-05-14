return {
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<C-,>",
                    accept_word = "<C-;>",
                },
                color = {
                    suggestion_color = "#550055",
                    cterm = 244,
                }
            })
        end,
    }
}
