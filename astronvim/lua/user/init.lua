local config = {
  updater = {
    remote = "origin",
    channel = "nightly",
    version = "latest",
    branch = "main",
    commit = nil,
    pin_plugins = nil,
    skip_prompts = false,
    show_changelog = true,
    auto_reload = false,
    auto_quit = false
  },

  colorscheme = "neosolarized",
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --	Normal = { bg = "#000000" },
    -- },
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  options = {
    opt = {
      termguicolors = true,
      ignorecase = true,
      wildignorecase = true,
      relativenumber = true,
      number = true,
      spell = false,
      signcolumn = "auto",
      wrap = false,
    },
    g = {
      mapleader = " ",
      autoformat_enabled = false,
      cmp_enabled = true,
      autopairs_enabled = true,
      diagnostics_enabled = true,
      status_diagnostics_enabled = true,
      icons_enabled = true,
      ui_notifications_enabled = true,
      heirline_bufferline = false,
    }
  },

  header = {
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    " ",
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },
  default_theme = {
    colors = {
      fg = "#abb2bf",
      bg = "#001E27",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"
      hl.Normal = { fg = C.fg, bg = C.bg }
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true
      return hl
    end,
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    }
  },

  diagnostics = { virtual_text = true, underline = true },

  lsp = {
    -- enable servers that you already have installed without mason
    servers = {},
    skip_setup = { "clangd", "rust-analyzer" },
    formatting = {
      format_on_save = {
        enabled = false,
        allow_filetypes = { "rust", "cpp", "c", "go" },
        ignore_filetypes = {}
      },
      disabled = {},
      timeout_ms = 1000,
      -- filter = function(client) -- fully override the default formatting function
      --		return true
      -- end
    },
    mappings = { n = { --[[ ["<leader>lf"] = false --]] } },
    ["server-settings"] = { clangd = { capabilities = { offsetEncoding = "utf-8" } } },
  },
  mappings = {
    n = {
      ["<leader>ff"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" },
      ["<leader>fg"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Find in files" },
      ["<leader>fb"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Find in buffers" },
      ["<leader>fh"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Find in tags" },
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      ["<ESC>"] = { "<cmd>:noh<cr>", desc = "Remove highlights from search results" },
      ["<C-c>"] = { "<cmd> %y+ <cr>", desc = "Copy buffer content to clipboard" },
      ["<F4>"] = { "<cmd>AerialToggle<cr>", desc = "Toggle Aerial (tag viewer)" },
      ["<F3>"] = { "<cmd>Neotree toggle<cr>", desc = "Open Neotree (file explorer)" },
      ["<F2>"] = { "<cmd>set number! norelativenumber!<cr>", desc = "Toggle numberline" },
      ["<leader>a"] = { "ggVG", desc = "Select all" },
    },
    t = {},
    v = {
      ["<F5>"] = { "<Plug>SnipRun<cr>", desc = "Execute :SnipRun in visual-selection mode" },
    },
  },

  plugins = {
    init = {
      { "sheerun/vim-polyglot" },
      { "svrana/neosolarized.nvim",
        config = function()
          require('neosolarized').setup { comment_italics = true, background_set = false }
        end,
      },
      { "tjdevries/colorbuddy.nvim" },
      { "lambdalisue/suda.vim" },
      { "p00f/clangd_extensions.nvim",
        after = "mason-lspconfig.nvim",
        config = function()
          require("clangd_extensions").setup { server = astronvim.lsp.server_settings "clangd" }
        end,
      },
      { "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim",
        config = function()
          require("rust-tools").setup { server = astronvim.lsp.server_settings "rust_analyzer" }
        end,
      },
      ["michaelb/sniprun"] = {
        run = "bash ./install.sh",
        config = function()
          require("sniprun").setup {
            inline_messages = 0,
            display = { "NvimNotify" },
            borders = "single",
            display_options = { notification_timeout = 2500 },
            interpreter_options = { Python3_original = { error_truncate = "long" } },
          }
        end,
      },
      ["rcarriga/nvim-notify"] = {
        event = "UIEnter",
        config = function() require("notify").setup { background_colour = "#001E27" }
          vim.notify = require("notify")
        end,
      },
      ["vladdoster/remember.nvim"] = { config = function() require("remember") end },
      ["max397574/better-escape.nvim"] = { disable = true },
      ["lukas-reineke/indent-blankline.nvim"] = { disable = true },
    },
    ["heirline"] = function()
      return {
        -- Status line:
        {
          hl = { fg = "fg", bg = "bg" },
          astronvim.status.component.mode(),
          astronvim.status.component.git_branch(),
          astronvim.status.component.file_info{ filename = { modify = ":p:." }, padding = { left = 1, right = 1 } },
          astronvim.status.component.git_diff(),
          astronvim.status.component.diagnostics(),
          astronvim.status.component.fill(),
          astronvim.status.component.macro_recording(),
          astronvim.status.component.fill(),
          astronvim.status.component.lsp(),
          astronvim.status.component.treesitter(),
          astronvim.status.component.nav{ scrollbar = false, percentage = false, padding = { left = 1 } },
          astronvim.status.component.mode { surround = { separator = "right" } },
        },
        -- Winbar:
        {
          hl = { fg = "fg", bg = "none" },
          astronvim.status.component.breadcrumbs { icon = { hl = true }, padding = { left = 1 } },
          astronvim.status.component.fill(),
          -- astronvim.status.component.git_diff(),
          -- astronvim.status.component.diagnostics(),
        },
      }
    end,

    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      config.sources = {
        null_ls.builtins.diagnostics.misspell,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.hover.printenv,
      }
      return config
    end,

    treesitter = {},
    ["mason-lspconfig"] = { ensure_installed = { "sumneko_lua", "rust_analyzer", "clangd", "pylsp" } },
    ["mason-null-ls"] = { ensure_installed = { "printenv", "shellcheck", "misspell" } },
    ["mason-nvim-dap"] = { --[[ ensure_installed = { "python" }, -- ]] },
  },

  luasnip = { filetype_extend = { javascript = { "javascriptreact" } }, vscode = { paths = {} } },

  cmp = { source_priority = { nvim_lsp = 1000, luasnip = 750, buffer = 500, path = 50 } },

  ["which-key"] = { register = { n = { ["<leader>"] = { ["b"] = { name = "Buffer" }, }, }, }, },

  polish = function()
    -- n = require("neosolarized").setup({ comment_italics = true })
    -- n.Group.new("TODO", n.colors.blue)
    -- vim.api.nvim_create_autocmd("ColorScheme", {
    --	command = "hi CursorLineNr guibg=clear",
    -- })
    -- vim.cmd("set tabstop=2")
    -- vim.cmd("set softtabstop=0")
    -- vim.cmd("set noexpandtab")
    -- vim.cmd("set shiftwidth=2")
  end,
}
return config
