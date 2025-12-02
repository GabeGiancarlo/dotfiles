--[[
================================================================================
  Editor Options and Settings
================================================================================
  Configure Neovim's built-in options for optimal development experience.
  These settings are applied before plugins are loaded.
================================================================================
--]]

local opt = vim.opt

-- ============================================================================
-- Line Numbers
-- ============================================================================
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.numberwidth = 4 -- Width of the number column

-- ============================================================================
-- Indentation
-- ============================================================================
opt.tabstop = 4 -- Number of spaces a tab counts for
opt.softtabstop = 4 -- Number of spaces for a tab in editing operations
opt.shiftwidth = 4 -- Number of spaces for each indentation level
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Smart auto-indenting on new lines
opt.autoindent = true -- Copy indent from current line to new line
opt.breakindent = true -- Preserve indentation in wrapped lines

-- ============================================================================
-- Text Display
-- ============================================================================
opt.wrap = false -- Don't wrap long lines
opt.linebreak = true -- Break lines at word boundaries when wrap is on
opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
opt.conceallevel = 0 -- Show all text (no concealing)

-- ============================================================================
-- Search
-- ============================================================================
opt.hlsearch = false -- Don't highlight all search matches
opt.incsearch = true -- Incremental search highlighting
opt.ignorecase = true -- Case-insensitive search...
opt.smartcase = true -- ...unless search contains capitals

-- ============================================================================
-- User Interface
-- ============================================================================
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.signcolumn = 'yes' -- Always show the sign column
opt.cursorline = true -- Highlight the current line
opt.showmode = false -- Don't show mode (shown in statusline)
opt.pumheight = 10 -- Max items in popup menu
opt.cmdheight = 1 -- Height of command line
opt.laststatus = 3 -- Global statusline
opt.showtabline = 2 -- Always show tabline

-- ============================================================================
-- Splits
-- ============================================================================
opt.splitbelow = true -- Open horizontal splits below
opt.splitright = true -- Open vertical splits to the right
opt.splitkeep = 'screen' -- Keep screen position when splitting

-- ============================================================================
-- Clipboard
-- ============================================================================
opt.clipboard = 'unnamedplus' -- Use system clipboard

-- ============================================================================
-- File Handling
-- ============================================================================
opt.undofile = true -- Persistent undo history
opt.undolevels = 10000 -- Maximum undo levels
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before overwriting
opt.swapfile = false -- Don't use swap files
opt.fileencoding = 'utf-8' -- File encoding

-- ============================================================================
-- Performance
-- ============================================================================
opt.updatetime = 200 -- Faster CursorHold event (default 4000ms)
opt.timeoutlen = 300 -- Time to wait for mapped sequence (ms)
opt.redrawtime = 1500 -- Time for redrawing the display

-- ============================================================================
-- Completion
-- ============================================================================
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.wildignorecase = true -- Case-insensitive file/directory completion

-- ============================================================================
-- Folding
-- ============================================================================
opt.foldlevel = 99 -- Start with all folds open
opt.foldlevelstart = 99 -- Start with all folds open
opt.foldenable = true -- Enable folding

-- ============================================================================
-- Miscellaneous
-- ============================================================================
opt.mouse = 'a' -- Enable mouse in all modes
opt.backspace = { 'indent', 'eol', 'start' } -- Better backspace behavior
opt.whichwrap:append '<>[]hl' -- Allow cursor to wrap to next/prev line
opt.shortmess:append 'sI' -- Reduce messages
opt.iskeyword:append '-' -- Treat hyphenated words as one word
opt.formatoptions:remove { 'c', 'r', 'o' } -- Don't auto-insert comment leaders

-- Disable providers we don't need
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- vim: ts=2 sts=2 sw=2 et

