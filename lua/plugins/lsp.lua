return {
  {
    "neovim/nvim-lspconfig",  -- Basis LSP Unterstützung
    dependencies = {
      { "williamboman/mason.nvim", config = true }, -- LSP Installer
      "williamboman/mason-lspconfig.nvim",          -- Verbindet mason mit lspconfig
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",      -- Lua
          "pyright",     -- Python
          "ts_ls",    -- TypeScript / JavaScript
          "bashls",      -- Bash
          "nil_ls",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      -- Beispiel: Lua LSP
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Weitere LSPS einfach so konfigurieren:
      lspconfig.pyright.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.bashls.setup({})
      lspconfig.nil_ls.setup({})
    end,
  }
}

