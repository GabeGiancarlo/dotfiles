--[[
================================================================================
  Autocommands
================================================================================
  Automatic commands that respond to Neovim events.
================================================================================
--]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- General
-- ============================================================================

-- Highlight text on yank
local yank_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
  desc = 'Highlight yanked text',
})

-- Remove trailing whitespace on save
local whitespace_group = augroup('TrimWhitespace', { clear = true })
autocmd('BufWritePre', {
  group = whitespace_group,
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos '.'
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.setpos('.', save_cursor)
  end,
  desc = 'Remove trailing whitespace',
})

-- ============================================================================
-- Window Behavior
-- ============================================================================

-- Resize splits when window is resized
local resize_group = augroup('ResizeSplits', { clear = true })
autocmd('VimResized', {
  group = resize_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
  desc = 'Resize splits on window resize',
})

-- Close certain windows with 'q'
local close_group = augroup('CloseWithQ', { clear = true })
autocmd('FileType', {
  group = close_group,
  pattern = {
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'query',
    'startuptime',
    'tsplayground',
    'checkhealth',
    'spectre_panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
  end,
  desc = 'Close certain windows with q',
})

-- ============================================================================
-- File Types
-- ============================================================================

-- Set specific options for certain file types
local filetype_group = augroup('FileTypeSettings', { clear = true })

-- Use 2-space indentation for web development files
autocmd('FileType', {
  group = filetype_group,
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'html', 'css', 'scss', 'yaml', 'lua' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = '2-space indent for web files',
})

-- Wrap and spell check for text files
autocmd('FileType', {
  group = filetype_group,
  pattern = { 'markdown', 'gitcommit', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
  end,
  desc = 'Wrap and spell check for text files',
})

-- ============================================================================
-- Cursor Position
-- ============================================================================

-- Return to last edit position when opening files
local cursor_group = augroup('RestoreCursor', { clear = true })
autocmd('BufReadPost', {
  group = cursor_group,
  callback = function(event)
    local exclude_filetypes = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' }
    if vim.tbl_contains(exclude_filetypes, vim.bo[event.buf].filetype) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = 'Restore cursor position',
})

-- ============================================================================
-- Large Files
-- ============================================================================

-- Optimize for large files
local large_file_group = augroup('LargeFile', { clear = true })
autocmd('BufReadPre', {
  group = large_file_group,
  callback = function(event)
    local file = event.match
    local size = vim.fn.getfsize(file)
    if size > 1024 * 1024 then -- 1MB
      vim.opt_local.eventignore:append 'FileType'
      vim.opt_local.undofile = false
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = 'manual'
    end
  end,
  desc = 'Optimize for large files',
})

-- ============================================================================
-- Terminal
-- ============================================================================

-- Terminal window settings
local terminal_group = augroup('TerminalSettings', { clear = true })
autocmd('TermOpen', {
  group = terminal_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd 'startinsert'
  end,
  desc = 'Terminal settings',
})

-- ============================================================================
-- Focus
-- ============================================================================

-- Check for file changes when focused
local focus_group = augroup('FocusCheck', { clear = true })
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = focus_group,
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
  desc = 'Check for file changes',
})

-- ============================================================================
-- File Type Detection
-- ============================================================================

-- Additional file type associations
vim.filetype.add {
  extension = {
    tf = 'terraform',
    tfvars = 'terraform',
    pipeline = 'groovy',
    multibranch = 'groovy',
    mdx = 'markdown',
    astro = 'astro',
  },
  filename = {
    ['.env'] = 'sh',
    ['.env.local'] = 'sh',
    ['.env.development'] = 'sh',
    ['.env.production'] = 'sh',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['Brewfile'] = 'ruby',
  },
  pattern = {
    ['%.env%.[%w_.-]+'] = 'sh',
  },
}

-- vim: ts=2 sts=2 sw=2 et

