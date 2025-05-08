return { {
  "timseriakov/spamguard.nvim",
  dependencies = {
    'rcarriga/nvim-notify'
  },
  event = "VeryLazy",
  config = function()
    local spamguard = require("spamguard")
    spamguard.setup({
      keys = {
        j = { threshold = 9, suggestion = "use s / C-dir instead of spamming jjjj 😎" },
        k = { threshold = 9, suggestion = "try { {[ C-u instead of spamming kkkk 😎" },
        h = { threshold = 9, suggestion = "use b / _ / ^ instead of spamming hhhh  😎" },
        l = { threshold = 9, suggestion = "try w / e / f char — it's faster! 😎" },
        w = { threshold = 8, suggestion = "use s / f char — more precise and quicker! 😎" },
      },
    })
    vim.schedule(function()
      spamguard.enable()
    end)
  end,
},
}
