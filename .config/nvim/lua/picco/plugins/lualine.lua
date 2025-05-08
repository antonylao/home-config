return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- Override specific highlights after the theme is set
    local custom_ayudark        = require("lualine.themes.ayu_dark")
    local light_grey            = "#808080"
    local light_green           = "#778DA9"
    local light_yellow          = "#DDA15E"
    local light_orange          = "#BC625"
    local red                   = "#E83151"
    -- Set same background for all available modes
    custom_ayudark.normal.a.bg  = light_grey
    custom_ayudark.replace.a.bg = red
    custom_ayudark.insert.a.bg  = light_green
    custom_ayudark.visual.a.bg  = light_yellow

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = "nightfly",
        --component_separators = { left = '', right = '' },
        --section_separators = { left = '', right = '' },

        component_separators = { '|' },
        section_separators = { '/' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }

      },
      sections = {
        lualine_a = { 'filename', },
        lualine_b = { { 'branch',
          fmt = function(str)
            local valid_git_branches = { main = true, master = true, develop = true, staging = true }
            if valid_git_branches[str] then return str else return '' end
          end,
          --color = { fg = custom_ayudark.normal.b.fg }
        }, 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        --lualine_x = { { 'branch', color = { fg = "#ffffff" } }, { 'diff', source = git_prompt() } },
        lualine_x = { 'lsp_status' },

        lualine_y = { 'progress' },
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
