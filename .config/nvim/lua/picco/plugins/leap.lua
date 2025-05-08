return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat"
  },
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'z', '<Plug>(leap)')
    vim.keymap.set('n', 'Z', '<Plug>(leap-from-window)')
  end
}
