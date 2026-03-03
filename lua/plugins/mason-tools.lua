return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      -- UWAGA: podaj poprawne nazwy z Masona (np. "lua-language-server" a nie "lua_ls")
      "lua-language-server",
      "clangd",
      "stylua",
      "prettier",
      -- Dodaj inne pakiety których używasz...
    },
  },
}
