print("hello from telescope")

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6', -- or branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-telescope/telescope-live-grep-args.nvim",
    {
      -- antony ~ 2025-05-04: had to go to the related folder
      -- (by default, in .local/share/nvim..) and `make`
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
  },
  config = function()
    local telescope = require('telescope')
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({

      --uncomment to set default theme to ivy
      -- antony ~ 2025-05-05: issues of showing bottom result
      --defaults = vim.tbl_extend("force", require('telescope.themes').get_ivy(), {
      --default options
      --  }
      --),
      pickers = {
        find_files = {
          find_command = {
            "rg", "--files", "--hidden", "--no-ignore-vcs", "--smart-case",
            "-g", "!**/.git/*", "-g", "!**/node_modules/*", "-g", "!**/build/*",
            "-g", "!**/dist/*",
          }
        },
        current_buffer_fuzzy_find = {
          previewer = false
        }
      },
      --FZF_DEFAULT_COMMAND = 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*, dist/*}"'
      --used for live grep and grep string
      vimgrep_argument = {
        "rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
        "--column", "--smart-case", "--follow", "--no-ignore-vcs", "hidden",
        "-g", "!**/.git/*", "-g", "!**/node_modules/*", "-g", "!**/build/*",
        "-g", "!**/dist/*",
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "respect_case"      -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        live_grep_args = {
          --uses: 'pattern_in_file' -t extension
          --      'pattern_in_file' --iglob **/path_pattern/**
          auto_quoting = false,
          additional_args = {
            "--smart-case", "--with-filename"
          },
          mappings = { -- extend mappings
            i = {
              ["<C-t>"] = lga_actions.quote_prompt(),
              ["<C-d>"] = lga_actions.quote_prompt({ postfix = " --iglob **/*/**", }),
              -- freeze the current list and start a fuzzy search in the frozen list
              --  antony ~ 2025-05-05: doesn't work
              ["<C-space>"] = lga_actions.to_fuzzy_refine,
            },
          },
        }
      },
    })

    -- load after config
    telescope.load_extension("live_grep_args")
    telescope.load_extension("fzf")

    local builtin = require('telescope.builtin')
    -- <C-u>, <C-d> to move the preview window
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set("n", "<leader>fW", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>fp', function()
      builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") }
    end
    , { desc = 'Telescope find packages' })
    vim.keymap.set("n", '<leader>/', builtin.current_buffer_fuzzy_find)
    -- NB: moved to lsp: telescope diagnostics
  end
}
