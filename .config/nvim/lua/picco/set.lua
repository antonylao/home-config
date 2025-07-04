--options can be checked/set with :set optname
vim.g.mapleader = " "

-- keep fat cursor but change color on insert mode
vim.api.nvim_set_hl(0, "iCursor", { fg = "white", bg = "darkmagenta" })
vim.api.nvim_set_hl(0, "Cursor", { fg = "black", bg = "white" })
vim.api.nvim_set_hl(0, "cCursor", { fg = "white", bg = "red" })

vim.opt.guicursor = "i:iCursor,r-o:cCursor,n-v:Cursor"
vim.opt.nu = true
vim.opt.relativenumber = true

--indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

--misc.
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"

--remove upper tabs showing buffers
vim.opt.showtabline = 0

-- for undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- disable global highlighting of search, but as you type you see the first result
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- allow @ and - char for filenames in nvim
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 300

vim.opt.colorcolumn = "80"
-- workaround to set color after this file is processed, doesn't work otherwise
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#242322" })
	end,
})
-- remove some errors from set of characters present in files
vim.opt.modeline = false
