vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set relativenumber")
vim.cmd("set scrolloff=8")
vim.cmd("set colorcolumn=100")
vim.cmd("set undofile")
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

vim.keymap.set("n", "<leader>b", "<C-o>", opts)
vim.keymap.set("n", "<leader>f", "<C-i>", opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

