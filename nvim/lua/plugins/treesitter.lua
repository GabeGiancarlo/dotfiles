--[[
================================================================================
  Treesitter Configuration
================================================================================
  Syntax highlighting, indentation, and text objects using Treesitter.
================================================================================
--]]

return {
  -- ========================================================================
  -- Treesitter Core
  -- ========================================================================
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    lazy = vim.fn.argc(-1) == 0,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },

    opts = {
      -- Languages to install
      ensure_installed = {
        -- Programming Languages
        'lua',
        'python',
        'rust',
        'go',
        'javascript',
        'typescript',
        'tsx',
        'java',
        'c',
        'cpp',
        'ruby',
        'swift',

        -- Web
        'html',
        'css',
        'scss',
        'graphql',
        'astro',
        'svelte',
        'vue',

        -- Data/Config
        'json',
        'jsonc',
        'yaml',
        'toml',
        'xml',

        -- DevOps
        'dockerfile',
        'terraform',
        'hcl',
        'bash',

        -- Documentation
        'markdown',
        'markdown_inline',
        'vimdoc',
        'regex',

        -- Git
        'gitcommit',
        'gitignore',
        'git_config',
        'git_rebase',
        'diff',

        -- Query/Database
        'sql',
        'query',

        -- Misc
        'vim',
        'make',
        'cmake',
        'groovy',
        'http',
        'jq',
      },

      -- Auto-install missing parsers when entering buffer
      auto_install = true,

      -- Highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Indentation
      indent = {
        enable = true,
      },

      -- Incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<BS>',
        },
      },

      -- Text objects
      textobjects = {
        -- Selection
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'Select around function' },
            ['if'] = { query = '@function.inner', desc = 'Select inside function' },
            ['ac'] = { query = '@class.outer', desc = 'Select around class' },
            ['ic'] = { query = '@class.inner', desc = 'Select inside class' },
            ['aa'] = { query = '@parameter.outer', desc = 'Select around argument' },
            ['ia'] = { query = '@parameter.inner', desc = 'Select inside argument' },
            ['al'] = { query = '@loop.outer', desc = 'Select around loop' },
            ['il'] = { query = '@loop.inner', desc = 'Select inside loop' },
            ['ai'] = { query = '@conditional.outer', desc = 'Select around conditional' },
            ['ii'] = { query = '@conditional.inner', desc = 'Select inside conditional' },
            ['ab'] = { query = '@block.outer', desc = 'Select around block' },
            ['ib'] = { query = '@block.inner', desc = 'Select inside block' },
          },
        },

        -- Movement
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = { query = '@function.outer', desc = 'Next function start' },
            [']c'] = { query = '@class.outer', desc = 'Next class start' },
            [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
          },
          goto_next_end = {
            [']F'] = { query = '@function.outer', desc = 'Next function end' },
            [']C'] = { query = '@class.outer', desc = 'Next class end' },
            [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
          },
          goto_previous_start = {
            ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
            ['[c'] = { query = '@class.outer', desc = 'Previous class start' },
            ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
          },
          goto_previous_end = {
            ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
            ['[C'] = { query = '@class.outer', desc = 'Previous class end' },
            ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
          },
        },

        -- Swap
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = { query = '@parameter.inner', desc = 'Swap next argument' },
          },
          swap_previous = {
            ['<leader>A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
          },
        },
      },
    },

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- ========================================================================
  -- Treesitter Context
  -- ========================================================================
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = nil,
      zindex = 20,
    },
    keys = {
      {
        '<leader>uc',
        function()
          require('treesitter-context').toggle()
          vim.notify('Treesitter Context: ' .. (require('treesitter-context').enabled() and 'ON' or 'OFF'), vim.log.levels.INFO)
        end,
        desc = 'Toggle Treesitter [C]ontext',
      },
    },
  },

  -- ========================================================================
  -- Auto-close and rename HTML tags
  -- ========================================================================
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
}

-- vim: ts=2 sts=2 sw=2 et

