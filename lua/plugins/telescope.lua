return{
    { 
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
        config = function()
            -- FZF Extension aktivieren
            require('telescope').load_extension('fzf')
        end,
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim' 
    },
    cmd = {
        "Telescope",
    },
    keys = {
        { "<S-g>", "<cmd>Telescope live_grep<cr>"},
        { "<S-f>", "<cmd>Telescope find_files<cr>", desc = "Grep project" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" }, 
    },
    
},
}
