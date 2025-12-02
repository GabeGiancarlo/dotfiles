--[[
================================================================================
  Editor Enhancement Configuration
================================================================================
  Various plugins to enhance the editing experience.
================================================================================
--]]

return {
  -- ========================================================================
  -- Comment.nvim - Easy commenting
  -- ========================================================================
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },

    opts = {
      padding = true,
      sticky = true,
      ignore = '^$',
      toggler = {
        line = 'gcc',
        block = 'gbc',
      },
      opleader = {
        line = 'gc',
        block = 'gb',
      },
      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
      },
    },

    config = function(_, opts)
      require('Comment').setup(opts)

      -- Additional keymaps for Ctrl+/
      local comment = require 'Comment.api'
      vim.keymap.set('n', '<C-/>', comment.toggle.linewise.current, { desc = 'Toggle comment' })
      vim.keymap.set('n', '<C-_>', comment.toggle.linewise.current, { desc = 'Toggle comment' })
      vim.keymap.set('v', '<C-/>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Toggle comment' })
      vim.keymap.set('v', '<C-_>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Toggle comment' })
    end,
  },

  -- ========================================================================
  -- Surround - Add/delete/change surroundings
  -- ========================================================================
  {
    'kylechui/nvim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    opts = {},
  },

  -- ========================================================================
  -- Mini.ai - Better text objects
  -- ========================================================================
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().googletag.pubads().refresh()googletag.pubads().refresh()googletag.pubads().refresh()googletag.pubads().refresh()' },
        },
      }
    end,
  },

  -- ========================================================================
  -- Sleuth - Automatic indentation detection
  -- ========================================================================
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- ========================================================================
  -- Undotree - Visualize undo history
  -- ========================================================================
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>uu', '<cmd>UndotreeToggle<cr>', desc = 'Toggle [U]ndotree' },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- ========================================================================
  -- Flash - Enhanced navigation
  -- ========================================================================
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = {
          enabled = false, -- Don't hijack regular search
        },
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
    },
  },

  -- ========================================================================
  -- Trouble - Pretty diagnostics list
  -- ========================================================================
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = '[C]ode [S]ymbols (Trouble)' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
    opts = {
      use_diagnostic_signs = true,
    },
  },

  -- ========================================================================
  -- Aerial - Code outline
  -- ========================================================================
  {
    'stevearc/aerial.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>o', '<cmd>AerialToggle!<cr>', desc = 'Code [O]utline' },
      { '{', '<cmd>AerialPrev<cr>', desc = 'Previous Symbol' },
      { '}', '<cmd>AerialNext<cr>', desc = 'Next Symbol' },
    },
    opts = {
      layout = {
        min_width = 30,
        default_direction = 'prefer_right',
      },
      attach_mode = 'global',
      backends = { 'treesitter', 'lsp', 'markdown', 'man' },
      show_guides = true,
      guides = {
        mid_item = '├─',
        last_item = '└─',
        nested_top = '│ ',
        whitespace = '  ',
      },
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
      },
    },
  },

  -- ========================================================================
  -- Better Escape - jk/kj to escape
  -- ========================================================================
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    opts = {
      timeout = 300,
      default_mappings = true,
      mappings = {
        i = {
          j = {
            k = '<Esc>',
            j = '<Esc>',
          },
          k = {
            j = '<Esc>',
          },
        },
      },
    },
  },

  -- ========================================================================
  -- Illuminate - Highlight word under cursor
  -- ========================================================================
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
      filetypes_denylist = {
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'lazy',
        'mason',
        'oil',
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      -- Navigate to next/previous reference
      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- Also set mappings on LspAttach
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
  },

  -- ========================================================================
  -- Spectre - Search and replace
  -- ========================================================================
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Spectre',
    keys = {
      { '<leader>sr', function() require('spectre').open() end, desc = '[S]earch & [R]eplace' },
      { '<leader>sw', function() require('spectre').open_visual({ select_word = true }) end, desc = '[S]earch current [W]ord' },
      { '<leader>sp', function() require('spectre').open_file_search({ select_word = true }) end, desc = '[S]earch in current file' },
    },
    opts = {
      open_cmd = 'noswapfile vnew',
    },
  },

  -- ========================================================================
  -- Terminal Integration
  -- ========================================================================
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = 'ToggleTerm',
    keys = {
      { '<C-`>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      { '<leader>tt', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]oggle [T]erminal (Float)' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal size=15<cr>', desc = '[T]erminal [H]orizontal' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', desc = '[T]erminal [V]ertical' },
    },
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-`>]],
      hide_numbers = true,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 0,
      },
      highlights = {
        FloatBorder = { link = 'FloatBorder' },
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      -- Terminal keymaps
      function _G.set_terminal_keymaps()
        local term_opts = { buffer = 0 }
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], term_opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], term_opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], term_opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], term_opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], term_opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], term_opts)
      end

      vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
    end,
  },

  -- ========================================================================
  -- Mini.pairs - Auto pairs (alternative if you prefer over autopairs)
  -- ========================================================================
  -- Disabled in favor of nvim-autopairs in completion.lua
  -- {
  --   'echasnovski/mini.pairs',
  --   event = 'VeryLazy',
  --   opts = {},
  -- },
}

-- vim: ts=2 sts=2 sw=2 et

