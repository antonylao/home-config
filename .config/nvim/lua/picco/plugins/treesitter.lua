local M = {
  "nvim-treesitter/nvim-treesitter",
  -- build = ":TSUpdate",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,

  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "html" },
      auto_install = true,
      sync_install = true,
      highlight = { enable = true },
    })
  end
}

return { M }
