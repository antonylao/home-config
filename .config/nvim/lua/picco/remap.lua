vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set({ "i", "v" }, "kj", "<Esc>")

-- move lines up and down in vmode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

--keep cursor at the same place with this command
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle with middle page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- when searching terms, cursors in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy paste clipboard
vim.keymap.set("n", "<leader>y", "\"+yiw")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>p", "\"+p")

-- Q is bullshit so disable it
vim.keymap.set("n", "Q", "<nop>")
-- C-z actually puts vim to the background. command fd to return to vim
-- vim.keymap.set("n", "<C-z>", "<nop>")

-- BEGIN: for JS
--
-- mz sets marker, `z goes back to marker
-- "ayiw copy into register a the inner word
-- o inserts on the line below
-- <CR> is enter
vim.keymap.set("n", "<leader>l",
  "mz\"ayiwoconsole.log(String.fromCodePoint(0x1F516) + \"<Esc>:r! echo %:t<CR>kJ A ~ <Esc>\"apa: \")<CR>console.log(<Esc>\"apa)<Esc>`z")
--
--original mapping commented below, this is is under testing
vim.keymap.set(
  "v",
  "<leader>l",
  "mz\"ayoconsole.log(String.fromCodePoint(0x1F516) + /<Esc>:r! echo %:t<CR>kJ A ~ <Esc>\"apA: /.source)<CR>console.log(<Esc>\"apA)<Esc>`z"
)
-- vim.keymap.set("v", "<leader>l", "mz\"ayoconsole.log(\"<Esc>:r! echo %:t<CR>kJ A ~ <Esc>\"apA: \" + <Esc>\"apA)<Esc>`z")
-- END: for JS


-- insert current file name (not used)
-- <C-R> (Ctrl + R) insert a register in insert mode
-- vim.keymap.set("n", "", "i<C-r>=expand(\"%:t\")<CR><Esc>")

-- for moving between projects (needs tmux: dont understand how it works)
-- vim.keymap.set("n", "<C-,>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
