return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap)")
		--vim.keymap.set('n', '', '<Plug>(leap-from-window)')
	end,
}
