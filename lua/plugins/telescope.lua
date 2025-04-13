return{
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim'  -- FZF Extension hinzufügen
    },
    cmd = {
        "Telescope",
    },
    keys = {
        { "<S-f>", "<cmd>Telescope live_grep<cr>"},
        { "<leader>ff", "<cmd>Telescope find_file<cr>", desc = "Grep project" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" }, 
    },
    config = function()
        -- FZF Extension aktivieren
        require('telescope').load_extension('fzf')
    end,
}
