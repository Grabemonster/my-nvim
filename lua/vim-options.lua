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
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, silent = true }

    -- gd → jump to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) 
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover,        opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) 
    vim.kkeymap.set('n', 'se', vim.diagnostic.open_float, opts)
  end,
})

