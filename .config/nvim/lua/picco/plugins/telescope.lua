print("hello from telescope")

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6', -- or branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      --FZF_DEFAULT_COMMAND = 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*, dist/*}"'
      --used for live grep and grep string
      vimgrep_argument = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--follow",
        "--no-ignore-vcs",
        "hidden",
        "-g",
        "!**/.git/*",
        "-g",
        "!**/node_modules/*",
        "-g",
        "!**/build/*",
        "-g",
        "!**/dist/*",
      },
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--no-ignore-vcs",
            "--smart-case",
            "-g",
            "!**/.git/*",
            "-g",
            "!**/node_modules/*",
            "-g",
            "!**/build/*",
            "-g",
            "!**/dist/*",
          }
        }
      },
      --defaults = {
      --  hidden = true,
      --  file_ignore_patterns = {
      --    "node_modules//*",
      --    "dist//*",
      --    "build//*",
      --    ".git//*"
      --  }
      --},
      --pickers = {
      --  find_files = {
      --    hidden = true,
      --  }
      --},
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
  end
}
