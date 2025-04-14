vim.g.mapleader = " "

--* keep fat cursor but change color on insert mode
vim.api.nvim_set_hl(0, "iCursor", { fg = "white", bg = "orange" })
vim.api.nvim_set_hl(0, "Cursor", { fg = "black", bg = "white" })
vim.opt.guicursor = "i:iCursor,n-v-c:Cursor"

vim.opt.nu = true
vim.opt.relativenumber = true

--indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = true

vim.opt.signcolumn = 'yes'

-- for undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- disable global highlighting of search, but as you type you see the first result
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- append the @ char to filenames ??
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 300

vim.opt.colorcolumn = "80"
