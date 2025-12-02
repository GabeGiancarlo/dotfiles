--[[
================================================================================
  Theme Configuration
================================================================================
  Color schemes and theme settings.
  Default theme: Catppuccin Mocha
================================================================================
--]]

return {
  -- ========================================================================
  -- Catppuccin (Primary Theme)
  -- ========================================================================
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      transparent_background = true,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
      },
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        gitsigns = true,
        harpoon = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        neotree = true,
        noice = true,
        notify = true,
        nvimtree = true,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          -- Make floating windows look nicer
          NormalFloat = { bg = 'NONE' },
          FloatBorder = { fg = colors.blue, bg = 'NONE' },

          -- Better visual selection
          Visual = { bg = colors.surface1 },

          -- Cursor line subtle
          CursorLine = { bg = colors.surface0 },

          -- Telescope
          TelescopeBorder = { fg = colors.blue, bg = 'NONE' },
          TelescopePromptBorder = { fg = colors.blue, bg = 'NONE' },
          TelescopeResultsBorder = { fg = colors.blue, bg = 'NONE' },
          TelescopePreviewBorder = { fg = colors.blue, bg = 'NONE' },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'

      -- Toggle transparency
      local transparent = true
      vim.keymap.set('n', '<leader>ut', function()
        transparent = not transparent
        require('catppuccin').setup {
          transparent_background = transparent,
        }
        vim.cmd.colorscheme 'catppuccin'
        vim.notify('Transparency: ' .. (transparent and 'ON' or 'OFF'), vim.log.levels.INFO)
      end, { desc = 'Toggle [T]ransparency' })
    end,
  },

  -- ========================================================================
  -- Tokyo Night (Alternative Theme)
  -- ========================================================================
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      style = 'night', -- night, storm, day, moon
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_colors = function(colors)
        colors.border = colors.blue
      end,
      on_highlights = function(hl, c)
        hl.TelescopeBorder = { fg = c.blue, bg = 'NONE' }
        hl.FloatBorder = { fg = c.blue, bg = 'NONE' }
      end,
    },
  },

  -- ========================================================================
  -- Nord (Alternative Theme)
  -- ========================================================================
  {
    'shaunsingh/nord.nvim',
    lazy = true,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
    end,
  },

  -- ========================================================================
  -- OneDark (Alternative Theme)
  -- ========================================================================
  {
    'navarasu/onedark.nvim',
    lazy = true,
    opts = {
      style = 'dark',
      transparent = true,
      term_colors = true,
      ending_tildes = false,
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },
      lualine = {
        transparent = true,
      },
      diagnostics = {
        darker = true,
        undercurl = true,
        background = false,
      },
    },
  },

  -- ========================================================================
  -- Kanagawa (Alternative Theme)
  -- ========================================================================
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {
      transparent = true,
      dimInactive = false,
      theme = 'wave', -- wave, dragon, lotus
      background = { dark = 'wave', light = 'lotus' },
    },
  },

  -- ========================================================================
  -- Rose Pine (Alternative Theme)
  -- ========================================================================
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    opts = {
      variant = 'moon', -- main, moon, dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

