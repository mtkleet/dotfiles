return {
  "michaelb/sniprun",
  -- binary_path = "${XDG_DATA_HOME}/nvim/lazy_snapshot/plugins/SnipRun/build/sniprun",
  build = "sh ./install.sh",
  opts = {
    inline_messages = 0,
    display = { "NvimNotify" },
    borders = "single",
    display_options = { notification_timeout = 2500 },
    interpreter_options = { Python3_original = { error_truncate = "long" } },
  },

  config = function(_, opts)
    -- alias nvim-notify -> snacks.notify
    package.loaded["notify"] = vim.notify
    require("sniprun").setup(opts)
  end,
}
