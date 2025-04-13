return {
    {'echasnovski/mini.nvim', 
    version = false,
    config = function()
        require('mini.ai').setup()
        require('mini.surround').setup()
    end},

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
