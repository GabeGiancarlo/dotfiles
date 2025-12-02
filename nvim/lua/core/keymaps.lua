--[[
================================================================================
  Key Mappings
================================================================================
  Global keymaps for Neovim. Plugin-specific keymaps are defined in their
  respective plugin configuration files.

  Leader key is set to <Space> in init.lua
================================================================================
--]]

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- General Mappings
-- ============================================================================

-- Disable spacebar default behavior in Normal and Visual modes
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Clear search highlights with <Esc>
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Save file
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
map('i', '<C-s>', '<Esc><cmd>w<CR>', { desc = 'Save file' })

-- Save without formatting
map('n', '<leader>sn', '<cmd>noautocmd w<CR>', { desc = '[S]ave [N]o format' })

-- Quit
map('n', '<C-q>', '<cmd>q<CR>', { desc = 'Quit' })

-- Force quit
map('n', '<leader>qq', '<cmd>qa!<CR>', { desc = 'Force quit all' })

-- ============================================================================
-- Better Navigation
-- ============================================================================

-- Move through wrapped lines naturally
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Center screen after scrolling
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

-- Center screen after search navigation
map('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

-- ============================================================================
-- Window Management
-- ============================================================================

-- Split windows
map('n', '<leader>sv', '<C-w>v', { desc = '[S]plit [V]ertical' })
map('n', '<leader>sh', '<C-w>s', { desc = '[S]plit [H]orizontal' })
map('n', '<leader>se', '<C-w>=', { desc = '[S]plit [E]qual size' })
map('n', '<leader>sx', '<cmd>close<CR>', { desc = '[S]plit close [X]' })

-- Navigate between windows
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize windows with arrow keys
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- ============================================================================
-- Buffer Management
-- ============================================================================

-- Navigate buffers
map('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- Preserve jump forward (Tab and C-i are the same in terminals)
map('n', '<C-i>', '<C-i>', opts)

-- Close buffer
map('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
map('n', '<leader>X', '<cmd>bdelete!<CR>', { desc = 'Force close buffer' })

-- New buffer
map('n', '<leader>bn', '<cmd>enew<CR>', { desc = '[B]uffer [N]ew' })

-- ============================================================================
-- Tab Management
-- ============================================================================

map('n', '<leader>to', '<cmd>tabnew<CR>', { desc = '[T]ab [O]pen new' })
map('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = '[T]ab close [X]' })
map('n', '<leader>tn', '<cmd>tabn<CR>', { desc = '[T]ab [N]ext' })
map('n', '<leader>tp', '<cmd>tabp<CR>', { desc = '[T]ab [P]revious' })

-- ============================================================================
-- Text Editing
-- ============================================================================

-- Delete single character without copying to register
map('n', 'x', '"_x', opts)

-- Better paste in visual mode (don't replace register content)
map('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- Keep cursor position when joining lines
map('n', 'J', 'mzJ`z', { desc = 'Join lines (keep cursor)' })

-- Better indenting (stay in visual mode)
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- Move lines up and down
map('n', '<A-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('i', '<A-j>', '<Esc><cmd>m .+1<CR>==gi', { desc = 'Move line down' })
map('i', '<A-k>', '<Esc><cmd>m .-2<CR>==gi', { desc = 'Move line up' })

-- Duplicate line
map('n', '<leader>dl', '<cmd>t.<CR>', { desc = '[D]uplicate [L]ine' })

-- ============================================================================
-- Quick Escape
-- ============================================================================

-- Fast escape from insert mode
map('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })
map('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })

-- ============================================================================
-- Yank and Clipboard
-- ============================================================================

-- Yank to system clipboard explicitly
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = '[Y]ank line to clipboard' })

-- Delete without yanking
map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete without yank' })

-- ============================================================================
-- Search and Replace
-- ============================================================================

-- Replace word under cursor
map('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [W]ord' })

-- Start replacing current word
map('n', '<leader>j', '*``cgn', { desc = 'Replace word (repeatable)' })

-- ============================================================================
-- Increment/Decrement Numbers
-- ============================================================================

map('n', '<leader>=', '<C-a>', { desc = 'Increment number' })
map('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })

-- ============================================================================
-- Toggle Options
-- ============================================================================

map('n', '<leader>uw', '<cmd>set wrap!<CR>', { desc = 'Toggle word [W]rap' })
map('n', '<leader>ur', '<cmd>set relativenumber!<CR>', { desc = 'Toggle [R]elative numbers' })
map('n', '<leader>us', '<cmd>set spell!<CR>', { desc = 'Toggle [S]pell check' })
map('n', '<leader>ul', '<cmd>set list!<CR>', { desc = 'Toggle [L]ist chars' })

-- ============================================================================
-- Diagnostics
-- ============================================================================

local diagnostics_active = true
map('n', '<leader>ud', function()
  diagnostics_active = not diagnostics_active
  vim.diagnostic.enable(diagnostics_active)
  if diagnostics_active then
    vim.notify('Diagnostics enabled', vim.log.levels.INFO)
  else
    vim.notify('Diagnostics disabled', vim.log.levels.INFO)
  end
end, { desc = 'Toggle [D]iagnostics' })

map('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Previous diagnostic' })

map('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Next diagnostic' })

map('n', '<leader>cd', vim.diagnostic.open_float, { desc = '[C]ode [D]iagnostic float' })
map('n', '<leader>cq', vim.diagnostic.setloclist, { desc = '[C]ode diagnostics [Q]uickfix' })

-- ============================================================================
-- Session Management
-- ============================================================================

map('n', '<leader>ss', '<cmd>mksession! .session.vim<CR>', { desc = '[S]ession [S]ave' })
map('n', '<leader>sl', '<cmd>source .session.vim<CR>', { desc = '[S]ession [L]oad' })

-- ============================================================================
-- Quickfix Navigation
-- ============================================================================

map('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix' })
map('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next quickfix' })
map('n', '<leader>co', '<cmd>copen<CR>', { desc = 'Open quickfix' })
map('n', '<leader>cc', '<cmd>cclose<CR>', { desc = 'Close quickfix' })

-- vim: ts=2 sts=2 sw=2 et

