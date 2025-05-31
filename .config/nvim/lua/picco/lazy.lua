local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- local pathOfThisFile = ...
-- local folderOfThisFile = (...):match("(.-)[^%.]+$")
require("lazy").setup({
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false, -- default: true
		notify = false, -- get a notification when changes are found
	},

	{ import = "picco.plugins.spamguard" },
	--apl keybindings
	-- 'https://github.com/PyGamer0/vim-apl',

	-- plenary
	"nvim-lua/plenary.nvim",

	"lewis6991/gitsigns.nvim", --gitsigns in gutter
	"nvim-tree/nvim-web-devicons", --symbols for various plugins

	--enhanced motion plugins
	{ "arnamak/stay-centered.nvim", opts = {} },
	{ import = "picco.plugins.leap" },
	{ import = "picco.plugins.treewalker" },
	{ import = "picco.plugins.surround" },

	--highlight chunk
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = { enable = true, duration = 200, delay = 100 },
				line_num = { enable = true, use_treesitter = true },
			})
		end,
	},
	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup({
				type = "matrix",
				intervals = 20,
				always_redraw = false,
				--cursor = "⍤",
				--cursor = "⌶",
				show_last_positions = "leave",
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp

				vim.keymap.set("n", "<leader>kn", "<cmd>NoiceDismiss<CR>"),
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	-- file navigation plugins
	-- test
	{ import = "picco.plugins.telescope" },
	--{ import = "picco.plugins.snacks-picker" },
	--{ import = 'picco.plugins.harpoon' },
	{ import = "picco.plugins.grapple" },

	-- syntax highlighting
	{ import = "picco.plugins.treesitter" },

	-- status line
	{ import = "picco.plugins.lualine" },
	{ import = "picco.plugins.twilight" },

	--cloak
	{ import = "picco.plugins.cloak" },

	--keep the context (function, case, if) on top
	--disable if slow: `:ContextToggle`
	{
		"nvim-treesitter/nvim-treesitter-context",
		enabled = false,
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})

			vim.keymap.set("n", "<leader>tc", vim.cmd.TSContextToggle)
		end,
	},
	{
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline

			vim.keymap.set("n", "<C-a>", "<cmd>Outline<CR><C-w><C-h>", { desc = "Toggle Outline" })

			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
				symbols = { filter = { "Boolean", "String", "Variable", exclude = true } },
				outline_window = {
					width = 30,
					relative_width = true,
				},
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	--undotree
	{
		"mbbill/undotree",
		-- can't replace config..end by `opts = {..}`
		config = function()
			vim.keymap.set("n", "<leader>z", vim.cmd.UndotreeToggle)
		end,
	},
	--fugitive
	{
		"tpope/vim-fugitive",
		config = function()
			--gs: get status
			vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
		end,
	},

	--coc for LSP
	--{ import = 'picco/plugins/coc' },
	{ import = "picco/plugins/lsp" },
})
