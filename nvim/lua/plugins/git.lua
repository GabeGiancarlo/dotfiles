--[[
================================================================================
  Git Integration Configuration
================================================================================
  Git-related plugins: Gitsigns, Fugitive, LazyGit.
================================================================================
--]]

return {
  -- ========================================================================
  -- Gitsigns - Git status in gutter
  -- ========================================================================
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },

    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, 'Next Hunk')

        map('n', '[h', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, 'Previous Hunk')

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, '[H]unk [S]tage')
        map('n', '<leader>hr', gs.reset_hunk, '[H]unk [R]eset')
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, '[H]unk [S]tage')
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, '[H]unk [R]eset')

        map('n', '<leader>hS', gs.stage_buffer, '[H]unk [S]tage Buffer')
        map('n', '<leader>hR', gs.reset_buffer, '[H]unk [R]eset Buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, '[H]unk [U]ndo Stage')
        map('n', '<leader>hp', gs.preview_hunk, '[H]unk [P]review')

        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, '[H]unk [B]lame')
        map('n', '<leader>hB', gs.toggle_current_line_blame, '[H]unk [B]lame Toggle')

        map('n', '<leader>hd', gs.diffthis, '[H]unk [D]iff')
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, '[H]unk [D]iff ~')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select Hunk')
      end,
    },
  },

  -- ========================================================================
  -- Fugitive - Git commands in Vim
  -- ========================================================================
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse' },
    dependencies = {
      'tpope/vim-rhubarb', -- GitHub integration
    },

    keys = {
      { '<leader>gg', '<cmd>Git<cr>', desc = '[G]it Status (Fu[g]itive)' },
      { '<leader>gd', '<cmd>Gvdiffsplit<cr>', desc = '[G]it [D]iff Split' },
      { '<leader>gp', '<cmd>Git push<cr>', desc = '[G]it [P]ush' },
      { '<leader>gl', '<cmd>Git pull<cr>', desc = '[G]it Pul[l]' },
      { '<leader>gB', '<cmd>Git blame<cr>', desc = '[G]it [B]lame File' },
    },
  },

  -- ========================================================================
  -- LazyGit - Git TUI
  -- ========================================================================
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy[G]it' },
    },

    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
      vim.g.lazygit_use_neovim_remote = 1
    end,
  },

  -- ========================================================================
  -- Diffview - Enhanced Diff View
  -- ========================================================================
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },

    keys = {
      { '<leader>gv', '<cmd>DiffviewOpen<cr>', desc = '[G]it [V]iew Diff' },
      { '<leader>gV', '<cmd>DiffviewClose<cr>', desc = '[G]it [V]iew Close' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it File [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it Repo [H]istory' },
    },

    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = 'diff2_horizontal',
        },
        merge_tool = {
          layout = 'diff3_horizontal',
          disable_diagnostics = true,
        },
        file_history = {
          layout = 'diff2_horizontal',
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

