return {
    {'echasnovski/mini.files',
    cmd = {'MiniFiles'},
    keys = {
        { "<leader>y", "<cmd>lua MiniFiles.open()<cr>"},
    },
    config = function()
        require('mini.files').setup()
    end,
}

}
