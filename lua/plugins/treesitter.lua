---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      treesitter = {
        highlight = true,
        indent = true,
        auto_install = true,
        ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    commit = false,
    pin = false,
    version = false,
    build = ":TSUpdate",
    config = function()
      local ts = require "nvim-treesitter"
      ts.setup()
      ts.install {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    commit = false,
    pin = false,
    version = false,
  },
}
