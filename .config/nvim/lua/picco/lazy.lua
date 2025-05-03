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
  --apl keybindings
  'https://github.com/PyGamer0/vim-apl',
  -- plenary
  "nvim-lua/plenary.nvim",

  -- file navigation plugins
  { import = 'picco.plugins.telescope' },
  { import = 'picco.plugins.harpoon' },

  -- syntax highlighting
  { import = 'picco.plugins.treesitter' },

  --"lewis6991/gitsigns.nvim",
  -- status line
  { import = 'picco.plugins.lualine' },

  --cloak
  { import = 'picco.plugins.cloak' },

  --keep the context (function, case, if) on top
  --disable if slow: `:ContextToggle`
  {
    'wellle/context.vim',
    config = function()
      vim.g.context_enabled = 0
      vim.keymap.set("n", "<leader>fc", vim.cmd.ContextToggle)
    end
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  --undotree
  {
    "mbbill/undotree",
    -- can't replace config..end by `opts = {..}`
    config = function()
      vim.keymap.set("n", "<leader>z", vim.cmd.UndotreeToggle)
    end
  },
  --fugitive
  {
    "tpope/vim-fugitive",
    config = function()
      --gs: get status
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },

  --coc for LSP
  { import = 'picco/plugins/coc' },

})
