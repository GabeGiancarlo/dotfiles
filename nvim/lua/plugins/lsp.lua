--[[
================================================================================
  LSP Configuration
================================================================================
  Language Server Protocol configuration using native Neovim LSP with Mason
  for server management.
================================================================================
--]]

return {
  -- ========================================================================
  -- LSP Config
  -- ========================================================================
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Mason - Package manager for LSP servers, linters, formatters
      { 'mason-org/mason.nvim', config = true },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- LSP status updates
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = { winblend = 0 },
          },
        },
      },

      -- Additional capabilities from nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },

    config = function()
      -- ====================================================================
      -- LSP Attach Autocommand
      -- ====================================================================
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local telescope = require 'telescope.builtin'

          -- Navigation
          map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', telescope.lsp_references, '[G]oto [R]eferences')
          map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
          map('gy', telescope.lsp_type_definitions, '[G]oto T[y]pe Definition')

          -- Symbols
          map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Actions
          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', 'v')

          -- Documentation
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

          -- Workspace
          map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          map('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, '[W]orkspace [L]ist Folders')

          -- ================================================================
          -- Highlight References
          -- ================================================================
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- ================================================================
          -- Inlay Hints Toggle
          -- ================================================================
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      -- ====================================================================
      -- Capabilities
      -- ====================================================================
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- ====================================================================
      -- Server Configurations
      -- ====================================================================
      local servers = {
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
              },
              diagnostics = {
                globals = { 'vim' },
                disable = { 'missing-fields' },
              },
              format = { enable = false },
              telemetry = { enable = false },
            },
          },
        },

        -- Python
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
              },
            },
          },
        },
        ruff = {},

        -- Rust
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = 'clippy' },
              diagnostics = { enable = true },
              inlayHints = {
                enable = true,
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
            },
          },
        },

        -- TypeScript/JavaScript
        ts_ls = {},

        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },

        -- JSON
        jsonls = {},

        -- YAML
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
              },
            },
          },
        },

        -- Bash
        bashls = {},

        -- Docker
        dockerls = {},
        docker_compose_language_service = {},

        -- Terraform
        terraformls = {},

        -- HTML/CSS
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        cssls = {},

        -- Tailwind CSS
        tailwindcss = {},

        -- SQL
        sqlls = {},
      }

      -- ====================================================================
      -- Mason Tool Installer
      -- ====================================================================
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Lua formatter
        'prettier', -- Web formatter
        'eslint_d', -- JS/TS linter
        'shfmt', -- Shell formatter
      })

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
        auto_update = false,
        run_on_start = true,
      }

      -- ====================================================================
      -- Setup Servers
      -- ====================================================================
      for server, cfg in pairs(servers) do
        cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
        vim.lsp.config(server, cfg)
        vim.lsp.enable(server)
      end
    end,
  },

  -- ========================================================================
  -- Mason UI
  -- ========================================================================
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = '[M]ason' } },
    build = ':MasonUpdate',
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

