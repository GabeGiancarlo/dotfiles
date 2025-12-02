--[[
================================================================================
  Debug Configuration
================================================================================
  Debugging support using DAP (Debug Adapter Protocol).
================================================================================
--]]

return {
  -- ========================================================================
  -- nvim-dap - Debug Adapter Protocol
  -- ========================================================================
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Debugger UI
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        keys = {
          {
            '<leader>du',
            function()
              require('dapui').toggle {}
            end,
            desc = '[D]ebug [U]I Toggle',
          },
          {
            '<leader>de',
            function()
              require('dapui').eval()
            end,
            desc = '[D]ebug [E]val',
            mode = { 'n', 'v' },
          },
        },
        opts = {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '→' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
          layouts = {
            {
              elements = {
                { id = 'scopes', size = 0.25 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
                { id = 'watches', size = 0.25 },
              },
              position = 'left',
              size = 40,
            },
            {
              elements = {
                { id = 'repl', size = 0.5 },
                { id = 'console', size = 0.5 },
              },
              position = 'bottom',
              size = 10,
            },
          },
        },
        config = function(_, opts)
          local dap = require 'dap'
          local dapui = require 'dapui'
          dapui.setup(opts)

          -- Automatically open/close DAP UI
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open {}
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close {}
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close {}
          end
        end,
      },

      -- Virtual text for debugger
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {
          enabled = true,
          enabled_commands = true,
          highlight_changed_variables = true,
          highlight_new_as_changed = false,
          show_stop_reason = true,
          commented = false,
          virt_text_pos = 'eol',
        },
      },

      -- Mason integration
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Language-specific debuggers
      'leoluz/nvim-dap-go',
      'mfussenegger/nvim-dap-python',
    },

    keys = {
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[D]ebug [B]reakpoint Condition',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = '[D]ebug Toggle [B]reakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = '[D]ebug [C]ontinue',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = '[D]ebug Run to [C]ursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = '[D]ebug [G]o to Line (No Execute)',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = '[D]ebug Step [I]nto',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = '[D]ebug Down Stack',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = '[D]ebug Up Stack',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = '[D]ebug Run [L]ast',
      },
      {
        '<leader>do',
        function()
          require('dap').step_out()
        end,
        desc = '[D]ebug Step [O]ut',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_over()
        end,
        desc = '[D]ebug Step [O]ver',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = '[D]ebug [P]ause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = '[D]ebug [R]EPL Toggle',
      },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = '[D]ebug [S]ession',
      },
      {
        '<leader>dt',
        function()
          require('dap').terminate()
        end,
        desc = '[D]ebug [T]erminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = '[D]ebug [W]idgets',
      },
      -- Function key shortcuts
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Continue' },
      { '<F10>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F11>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F12>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    },

    config = function()
      local dap = require 'dap'

      -- DAP signs
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })

      -- Mason-nvim-dap setup
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'debugpy', -- Python
          'delve', -- Go
          'codelldb', -- Rust/C/C++
        },
      }

      -- Python configuration
      require('dap-python').setup()

      -- Go configuration
      require('dap-go').setup()

      -- Rust/C/C++ configuration (codelldb)
      local codelldb_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb'
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb_path,
          args = { '--port', '${port}' },
        },
      }

      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.c = dap.configurations.rust
      dap.configurations.cpp = dap.configurations.rust
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

