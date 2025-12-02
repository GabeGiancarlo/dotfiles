--[[
================================================================================
  UI Configuration
================================================================================
  User interface enhancements: statusline, bufferline, dashboard, notifications.
================================================================================
--]]

return {
  -- ========================================================================
  -- Lualine - Statusline
  -- ========================================================================
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    opts = function()
      local colors = {
        bg = 'NONE',
        fg = '#c0caf5',
        blue = '#7aa2f7',
        green = '#9ece6a',
        purple = '#bb9af7',
        cyan = '#7dcfff',
        red = '#f7768e',
        yellow = '#e0af68',
        orange = '#ff9e64',
        gray = '#565f89',
      }

      return {
        options = {
          theme = 'auto',
          globalstatus = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { 'alpha', 'dashboard', 'neo-tree' },
            winbar = {},
          },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(str)
                return ' ' .. str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            { 'branch', icon = '' },
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = '[No Name]',
                newfile = '[New]',
              },
            },
            {
              'diff',
              colored = true,
              symbols = {
                added = ' ',
                modified = ' ',
                removed = ' ',
              },
            },
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              sections = { 'error', 'warn', 'info', 'hint' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
              colored = true,
              update_in_insert = false,
              always_visible = false,
            },
            { 'encoding', cond = function() return vim.fn.winwidth(0) > 80 end },
            { 'filetype', icon_only = true },
          },
          lualine_y = {
            { 'progress' },
          },
          lualine_z = {
            { 'location' },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'neo-tree', 'lazy', 'fugitive', 'oil' },
      }
    end,
  },

  -- ========================================================================
  -- Bufferline - Buffer tabs
  -- ========================================================================
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'moll/vim-bbye',
    },

    keys = {
      { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = '[B]uffer [P]in' },
      { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = '[B]uffer close un[P]inned' },
      { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = '[B]uffer close [O]thers' },
      { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = '[B]uffer close [R]ight' },
      { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = '[B]uffer close [L]eft' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Buffer Previous' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Buffer Next' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Buffer Previous' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Buffer Next' },
    },

    opts = {
      options = {
        mode = 'buffers',
        themable = true,
        numbers = 'none',
        close_command = 'Bdelete! %d',
        right_mouse_command = 'Bdelete! %d',
        left_mouse_command = 'buffer %d',
        buffer_close_icon = '󰅖',
        close_icon = '',
        path_components = 1,
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        diagnostics = 'nvim_lsp',
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = 'insert_at_end',
      },
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
      },
    },
  },

  -- ========================================================================
  -- Alpha - Dashboard
  -- ========================================================================
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- Header
      dashboard.section.header.val = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                    ]],
      }

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
        dashboard.button('n', '  New file', ':ene <BAR> startinsert<CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
        dashboard.button('g', '󰊄  Find text', ':Telescope live_grep<CR>'),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC<CR>'),
        dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
        dashboard.button('m', '  Mason', ':Mason<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      -- Footer
      dashboard.section.footer.val = function()
        local stats = require('lazy').stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
      end

      -- Layout
      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'
      dashboard.section.footer.opts.hl = 'AlphaFooter'

      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'alpha',
        callback = function()
          vim.opt_local.foldenable = false
        end,
      })
    end,
  },

  -- ========================================================================
  -- Indent Blankline - Indentation guides
  -- ========================================================================
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',

    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = {
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
        },
      },
    },
  },

  -- ========================================================================
  -- Which-key - Keybinding hints
  -- ========================================================================
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',

    opts = {
      delay = 500,
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      win = {
        border = 'rounded',
        padding = { 2, 2, 2, 2 },
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = 'left',
      },
    },

    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)

      -- Register group names
      wk.add {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ebug/[D]iagnostics' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = '[H]unk' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]ab' },
        { '<leader>u', group = '[U]I/Toggle' },
        { '<leader>w', group = '[W]orkspace' },
      }
    end,
  },

  -- ========================================================================
  -- Noice - UI improvements
  -- ========================================================================
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },

    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
    },
  },

  -- ========================================================================
  -- Notify - Better notifications
  -- ========================================================================
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss [N]otifications',
      },
    },

    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      stages = 'fade_in_slide_out',
      render = 'wrapped-compact',
      background_colour = '#000000',
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },

    init = function()
      vim.notify = require 'notify'
    end,
  },

  -- ========================================================================
  -- Todo Comments
  -- ========================================================================
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },

    keys = {
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next [T]odo Comment',
      },
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous [T]odo Comment',
      },
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odos' },
    },

    opts = {
      signs = true,
      keywords = {
        FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
    },
  },

  -- ========================================================================
  -- Colorizer - Color highlighting
  -- ========================================================================
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },

    config = function()
      require('colorizer').setup({
        'css',
        'scss',
        'html',
        'javascript',
        'typescript',
        'lua',
        'vim',
      }, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },

  -- ========================================================================
  -- Dressing - Better UI
  -- ========================================================================
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },

  -- ========================================================================
  -- Web Devicons
  -- ========================================================================
  { 'nvim-tree/nvim-web-devicons', lazy = true },
}

-- vim: ts=2 sts=2 sw=2 et

