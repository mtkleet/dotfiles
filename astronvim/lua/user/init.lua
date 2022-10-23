local config = {
	updater = {
		remote = "origin", -- remote to use
		channel = "nightly", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_reload = false, -- automatically reload and sync packer after a successful update
		auto_quit = false, -- automatically quit the current session after a successful update
	},

	colorscheme = "neosolarized",
	highlights = {
		-- init = { -- this table overrides highlights in all themes
		--	Normal = { bg = "#073642" },
		-- },
		-- duskfox = { -- a table of overrides/changes to the duskfox theme
		--   Normal = { bg = "#000000" },
		-- },
	},

	options = {
		opt = {
			termguicolors = true,
			relativenumber = true,
			number = true,
			spell = false,
			signcolumn = "auto",
			wrap = false,
			ignorecase = true,
		},
		g = {
			mapleader = " ",
			autoformat_enabled = true,
			cmp_enabled = true,
			autopairs_enabled = true,
			diagnostics_enabled = true,
			status_diagnostics_enabled = true,
			icons_enabled = true
		},
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
			-- fg = "#abb2bf",
			bg = "none",
		},
		highlights = function(hl) -- or a function that returns a new table of colors to set
			local C = require("default_theme.colors")
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
			dashboard = true,
			highlighturl = true,
			hop = false,
			lightspeed = false,
			luasnip = true,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = false,
			["nvim-web-devicons"] = true,
			rainbow = true,
			snipmate = true,
			symbols_outline = false,
			telescope = true,
			treesitter = true,
			vimwiki = false,
			["which-key"] = true,
		},
	},

	diagnostics = {
		virtual_text = true,
		underline = true,
		update_in_insert = false,
	},

	lsp = {
		-- enable servers that you already have installed without mason
		servers = {
			-- "pyright"
		},
		formatting = {
			format_on_save = {
				enabled = true,
				disabled_filetypes = {},
			},
			disabled = {
				-- sumneko_lua
			},
			-- filter = function(client) -- fully override the default formatting function
			--		return true
			-- end
		},

		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		["server-settings"] = {
			-- example for addings schemas to yamlls
			-- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },
		},
	},

	mappings = {
		n = {
			["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
			["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
			["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
			["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
			["<ESC>"] = { ":noh<cr>", desc = "Remove highlights from search results" },
			["<C-s>"] = { ":w!<cr>", desc = "Save file" },
			["<C-c>"] = { "<cmd> %y+ <cr>", desc = "Copy to clipboard" },
			["<leader>a"] = { "ggVG", desc = "Select all" }
		},
		t = {},
	},

	plugins = {
		init = {
			{ "svrana/neosolarized.nvim" },
			{ "tjdevries/colorbuddy.nvim" },
			{ "sheerun/vim-polyglot" },
			["michaelb/sniprun"] = { run = "bash ./install.sh" },
			["rcarriga/nvim-notify"] = {
				config = function()
					require("notify").setup({ background_colour = "#073642" })
					vim.notify = require("notify")
				end
			},
			["vladdoster/remember.nvim"] = { config = function() require("remember") end },
			["declancm/cinnamon.nvim"] = { disable = true },
			["max397574/better-escape.nvim"] = { disable = true },
			["lukas-reineke/indent-blankline.nvim"] = { disable = true }
		},

		["null-ls"] = function(config)
			config.sources = {}
			return config
		end,
		treesitter = { -- overrides `require("treesitter").setup(...)`
			-- ensure_installed = { "lua" },
		},
		-- use mason-lspconfig to configure LSP installations
		["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
			-- ensure_installed = { "sumneko_lua" },
		},
		-- use mason-tool-installer to configure DAP/Formatters/Linter installation
		["mason-null-ls"] = { -- overrides `require("mason-tool-installer").setup(...)`
			-- ensure_installed = { "prettier", "stylua" },
		}
	},

	luasnip = {
		vscode_snippet_paths = {},
		filetype_extend = {
			--	javascript = { "javascriptreact" },
		}
	},

	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250
		}
	},

	sniprun = {
		inline_messages = 0,
		display = { "NvimNotifyOk", "NvimNotifyErr" },
		display_options = { notification_timeout = 5 },
		interpreter_options = {
			Python3_original = { error_truncate = "long" }
		},
		borders = "single",
		live_mode_toogle = "off"
	},

	["which-key"] = {
		register = {
			n = {
				["<leader>"] = {
					["b"] = { name = "Buffer" },
				},
			},
		},
	},

	polish = function()
		n = require("neosolarized").setup({ comment_italics = true })
		n.Group.new("TODO", n.colors.blue)
		-- vim.api.nvim_create_autocmd("ColorScheme", {
		--	command = "hi CursorLineNr guibg=clear",
		-- })
		vim.cmd("colorscheme neosolarized")
	end
}
return config
