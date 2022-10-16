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

	colorscheme = "solarized",
	highlights = {},

	options = {
		opt = {
			termguicolors = true,
			background = "dark",
			relativenumber = true,
			number = true,
			spell = false,
			signcolumn = "auto",
			wrap = false,
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			cmp_enabled = true,
			autopairs_enabled = true,
			diagnostics_enabled = true,
			status_diagnostics_enabled = true,
			solarized_termtrans = 1,
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
		-- Modify the color palette for the default theme
		colors = {
			-- fg = "#abb2bf",
			bg = "none",
		},
		highlights = function(hl) -- or a function that returns a new table of colors to set
			local C = require("solarized.colors")

			hl.Normal = { fg = C.fg, bg = C.bg }

			hl.DiagnosticError.italic = true
			hl.DiagnosticHint.italic = true
			hl.DiagnosticInfo.italic = true
			hl.DiagnosticWarn.italic = true

			return hl
		end,
		-- enable or disable highlighting for extra plugins
		plugins = {
			aerial = true,
			beacon = true,
			bufferline = true,
			dashboard = true,
			highlighturl = true,
			hop = true,
			indent_blankline = true,
			lightspeed = true,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = true,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = true,
			telescope = true,
			vimwiki = true,
			["which-key"] = true,
		},
	},

	-- Diagnostics configuration (for vim.diagnostics.config({...}))
	diagnostics = {
		virtual_text = true,
		underline = true,
		update_on_insert = false,
	},

	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without mason
		servers = {
			-- "pyright"
		},
		formatting = {
			format_on_save = true,
			disabled = {
				-- "sumneko_lua"
			},
			-- filter = function(client) -- fully override the default formatting function
			--   return true
			-- end
		},
		-- easily add or disable built in mappings added during LSP attaching
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
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			-- mappings seen under group name "Buffer"
			["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
			["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
			["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
			["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
			["<C-s>"] = { ":w!<cr>", desc = "Save File" },
			["<esc>"] = { ":noh<cr>", desc = "No highlight" },
		},
		t = {
			-- setting a mapping to false will disable it
		},
	},

	-- Configure plugins
	plugins = {
		init = {
			{ "ishan9299/nvim-solarized-lua" },
			["vladdoster/remember.nvim"] = {
				config = function()
					require("remember")
				end,
			},
			["declancm/cinnamon.nvim"] = { disable = true },
			["lukas-reineke/indent-blankline.nvim"] = { disable = true },
		},
		["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
			config.sources = {
				-- Set a formatter
				-- null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.prettier,
			}
			return config
		end,
		treesitter = { -- overrides `require("treesitter").setup(...)`
			-- ensure_installed = { "lua" },
		},
		-- use mason-lspconfig to configure LSP installations
		["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
			-- ensure_installed = { "sumneko_lua" },
		},
		["mason-null-ls"] = {
			-- ensure_installed = { "prettier", "stylua" },
		},
	},

	luasnip = {
		vscode_snippet_paths = {},
		filetype_extend = {},
	},

	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Modify which-key registration (Use this with mappings table in the above.)
	["which-key"] = {
		-- Add bindings which show up as group name
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- third key is the key to bring up next level and its displayed
					-- group name in which-key top level menu
					["b"] = { name = "Buffer" },
				},
			},
		},
	},

	polish = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			command = "hi LineNr guibg=clear",
		})
		vim.api.nvim_create_autocmd("ColorScheme", {
			command = "hi CursorLineNr guibg=clear",
		})
		vim.cmd("colorscheme solarized")
	end,
}
return config
