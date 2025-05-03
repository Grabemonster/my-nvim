-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
-- Setup lazy.nvim
local is_nixos = vim.fn.filereadable("/etc/NIXOS") == 1

local plugin_specs = {
  { import = "plugins" },
}

if is_nixos then
  table.insert(plugin_specs, { import = "plugins.nixos" })
else
  table.insert(plugin_specs, {import = "plugins.standart" })
end

require("lazy").setup({
  spec = plugin_specs,
  checker = { enabled = true },
})
