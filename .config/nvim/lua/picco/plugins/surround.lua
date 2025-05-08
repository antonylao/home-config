return {
	"kylechui/nvim-surround",
	version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
			-- to insert different things on left and right, use 'i' after the text-object
			-- ex: ysiwi
			-- NB: reminder of text-objects: t:tag b:() B:{}
			--     added for surround: f: function
			keymaps = {
				--C-g do'esn't 'do anything in my case..
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				--add to the whole line
				normal_cur = "yss",
				-- add surround on seperate line
				normal_line = "yS",
				normal_cur_line = "ySS",
				-- antony ~ 2025-05-08: doesn't conflict with leap plugin mapping
				-- first go in visual mode, then press S/gS to surround
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
		})
	end,
}
