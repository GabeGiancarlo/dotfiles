--[[
================================================================================
  Telescope Configuration
================================================================================
  Fuzzy finder for files, buffers, grep, and much more.
================================================================================
--]]

return {
  -- ========================================================================
  -- Telescope Core
  -- ========================================================================
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',

      -- FZF sorter for better performance
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      -- UI Select integration
      'nvim-telescope/telescope-ui-select.nvim',
    },

    keys = {
      -- Files
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[F]ind [F]iles' },
      { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[S]earch [F]iles' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = '[F]ind [R]ecent files' },
      { '<leader>so', '<cmd>Telescope oldfiles<cr>', desc = '[S]earch [O]ld files' },

      -- Buffers
      { '<leader><leader>', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = '[F]ind [B]uffers' },
      { '<leader>sb', '<cmd>Telescope buffers<cr>', desc = '[S]earch [B]uffers' },

      -- Text search
      { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by [G]rep' },
      { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [W]ord' },
      { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[/] Search in buffer' },

      -- Git
      { '<leader>gf', '<cmd>Telescope git_files<cr>', desc = '[G]it [F]iles' },
      { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = '[G]it [C]ommits' },
      { '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = '[G]it [B]ranches' },
      { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = '[G]it [S]tatus' },

      -- Help/Diagnostics
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', '<cmd>Telescope resume<cr>', desc = '[S]earch [R]esume' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
      { '<leader>sc', '<cmd>Telescope commands<cr>', desc = '[S]earch [C]ommands' },
      { '<leader>sm', '<cmd>Telescope marks<cr>', desc = '[S]earch [M]arks' },

      -- Neovim
      { '<leader>sn', '<cmd>Telescope notify<cr>', desc = '[S]earch [N]otifications' },
      { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },

      -- LSP (additional to those defined in lsp.lua)
      { '<leader>ss', '<cmd>Telescope lsp_document_symbols<cr>', desc = '[S]earch Document [S]ymbols' },
    },

    opts = function()
      local actions = require 'telescope.actions'

      return {
        defaults = {
          prompt_prefix = ' ',
          selection_caret = ' ',
          path_display = { 'truncate' },
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },

          -- File ignoring
          file_ignore_patterns = {
            'node_modules',
            '.git/',
            '.venv/',
            '__pycache__',
            '%.lock',
            'target/',
            'dist/',
            'build/',
          },

          -- Mappings
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-n>'] = actions.move_selection_next,
              ['<C-p>'] = actions.move_selection_previous,
              ['<C-c>'] = actions.close,
              ['<CR>'] = actions.select_default,
              ['<C-s>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,
              ['<C-t>'] = actions.select_tab,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
              ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
              ['q'] = actions.close,
              ['<Esc>'] = actions.close,
              ['<CR>'] = actions.select_default,
              ['<C-s>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,
              ['<C-t>'] = actions.select_tab,
              ['j'] = actions.move_selection_next,
              ['k'] = actions.move_selection_previous,
              ['H'] = actions.move_to_top,
              ['M'] = actions.move_to_middle,
              ['L'] = actions.move_to_bottom,
              ['gg'] = actions.move_to_top,
              ['G'] = actions.move_to_bottom,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
              ['dd'] = actions.delete_buffer,
            },
          },
        },

        pickers = {
          find_files = {
            hidden = true,
            follow = true,
          },
          live_grep = {
            additional_args = function()
              return { '--hidden' }
            end,
          },
          buffers = {
            initial_mode = 'normal',
            sort_lastused = true,
            sort_mru = true,
            show_all_buffers = true,
          },
          oldfiles = {
            initial_mode = 'normal',
          },
          marks = {
            initial_mode = 'normal',
          },
          git_status = {
            initial_mode = 'normal',
          },
        },

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }
    end,

    config = function(_, opts)
      local telescope = require 'telescope'
      telescope.setup(opts)

      -- Load extensions
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

