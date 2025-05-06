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
    notify = false,  -- get a notification when changes are found
  },

  --apl keybindings
  -- 'https://github.com/PyGamer0/vim-apl',

  -- plenary
  "nvim-lua/plenary.nvim",

  -- file navigation plugins
  { import = 'picco.plugins.telescope' },
  --TODO: antony ~ 2025-05-07: test grapple to replace harpoon (saves buffer cursor)
  --{ import = 'picco.plugins.harpoon' },
  {
    "cbochs/grapple.nvim",
    opts = {
      scope = "git", -- also try out "git_branch"
      icons = false, -- setting to "true" requires "nvim-web-devicons"
      status = true,
    },
    keys = {
      { "<c-s>",      "<cmd>Grapple toggle<cr>",         desc = "Tag a file" },
      { "<c-h>",      "<cmd>Grapple toggle_tags<cr>",    desc = "Toggle tags menu" },

      { "<leader>é",  "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
      { "<leader>\"", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
      { "<leader>'",  "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
      { "<leader>(",  "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
    },
  },
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
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
        symbols = { filter = { 'Boolean', 'String', 'Variable', exclude = true }, },
        outline_window = {
          width = 50,
          relative_width = true,
        },
      }
    end,
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
      vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
    end
  },

  --coc for LSP
  --{ import = 'picco/plugins/coc' },
  { import = 'picco/plugins/lsp' },

})
