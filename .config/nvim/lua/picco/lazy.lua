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
	{ import = "picco.plugins.leap" },
	{ import = "picco.plugins.treewalker" },
	{ import = "picco.plugins.surround" },

	--test: highlight chunk
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = { enable = true },
				line_num = { enable = true, use_treesitter = true },
			})
		end,
	},
	-- file navigation plugins
	{ import = "picco.plugins.telescope" },
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
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
				symbols = { filter = { "Boolean", "String", "Variable", exclude = true } },
				outline_window = {
					width = 50,
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
