return {
  "cbochs/grapple.nvim",
  opts = {
    scope = "git",   -- also try out "git_branch"
    icons = false,   -- setting to "true" requires "nvim-web-devicons"
    status = true,
  },
  keys = {
    { "<c-s>",      "<cmd>Grapple toggle<cr>",         desc = "Tag a file" },
    { "<c-x>",      "<cmd>Grapple toggle_tags<cr>",    desc = "Toggle tags menu" },

    { "<leader>é",  "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
    { "<leader>\"", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
    { "<leader>'",  "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
    { "<leader>(",  "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
  },
}
