return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide" },
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndoTree Toggle" }
  },
  config = function()
    -- Optional: Automatisch öffnen bei nvim-Start
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
