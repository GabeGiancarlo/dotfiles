--[[
================================================================================
  Formatting Configuration
================================================================================
  Code formatting using none-ls (formerly null-ls) and conform.nvim.
================================================================================
--]]

return {
  -- ========================================================================
  -- Conform.nvim - Formatter
  -- ========================================================================
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = { 'n', 'v' },
        desc = '[C]ode [F]ormat',
      },
    },

    opts = {
      -- Formatters by file type
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        rust = { 'rustfmt' },
        go = { 'gofumpt', 'goimports' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
        terraform = { 'terraform_fmt' },
        sql = { 'sql_formatter' },
        ['_'] = { 'trim_whitespace' },
      },

      -- Format on save
      format_on_save = function(bufnr)
        -- Disable for certain filetypes
        local ignore_filetypes = { 'sql', 'java' }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        -- Disable with a global variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return {
          timeout_ms = 3000,
          lsp_fallback = true,
        }
      end,

      -- Custom formatter configurations
      formatters = {
        shfmt = {
          prepend_args = { '-i', '4' },
        },
        prettier = {
          prepend_args = { '--tab-width', '2' },
        },
      },
    },

    init = function()
      -- Create commands to toggle format on save
      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- Disable for current buffer
          vim.b.disable_autoformat = true
          vim.notify('Format on save disabled for buffer', vim.log.levels.INFO)
        else
          -- Disable globally
          vim.g.disable_autoformat = true
          vim.notify('Format on save disabled globally', vim.log.levels.INFO)
        end
      end, { desc = 'Disable format on save', bang = true })

      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        vim.notify('Format on save enabled', vim.log.levels.INFO)
      end, { desc = 'Enable format on save' })

      -- Keymap to toggle format on save
      vim.keymap.set('n', '<leader>uf', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify('Format on save: ' .. (vim.g.disable_autoformat and 'OFF' or 'ON'), vim.log.levels.INFO)
      end, { desc = 'Toggle [F]ormat on save' })
    end,
  },

  -- ========================================================================
  -- none-ls.nvim - Linters and additional formatters
  -- ========================================================================
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
      'mason-org/mason.nvim',
    },

    config = function()
      local null_ls = require 'null-ls'
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup {
        debug = false,
        sources = {
          -- Linters
          diagnostics.checkmake,

          -- ESLint for JavaScript/TypeScript
          require 'none-ls.diagnostics.eslint_d',

          -- Code actions
          require 'none-ls.code_actions.eslint_d',
        },
      }
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

