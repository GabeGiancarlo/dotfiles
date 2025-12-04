# Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

A comprehensive, modular Neovim configuration built for professional development.

**[Installation](#installation) · [Keybindings](#keybindings) · [Plugins](#plugins) · [Customization](#customization)**

</div>

---

## ✨ Features

- 🚀 **Fast Startup** - Lazy-loaded plugins with lazy.nvim
- 🎨 **Beautiful UI** - Catppuccin theme with transparency support
- 📦 **LSP Support** - Intelligent code completion, diagnostics, and navigation
- 🌳 **Treesitter** - Advanced syntax highlighting and text objects
- 🔍 **Fuzzy Finding** - Telescope for files, grep, and more
- 📁 **File Navigation** - Neo-tree, Oil.nvim, and Harpoon
- 🐙 **Git Integration** - Gitsigns, Fugitive, and LazyGit
- 🐛 **Debugging** - DAP with support for Python, Go, Rust, and more
- ✍️ **Formatting** - Automatic code formatting with conform.nvim
- ⌨️ **Which-Key** - Interactive keybinding hints

---

## 📋 Table of Contents

- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Quick Start](#quick-start)
  - [Platform-Specific Notes](#platform-specific-notes)
  - [Post-Installation](#post-installation)
- [Keybindings](#keybindings)
  - [General](#general)
  - [Navigation](#navigation)
  - [Windows and Splits](#windows-and-splits)
  - [Buffers and Tabs](#buffers-and-tabs)
  - [File Explorer](#file-explorer)
  - [Telescope](#telescope)
  - [LSP](#lsp)
  - [Git](#git)
  - [Debugging](#debugging)
  - [Editing](#editing)
  - [Terminal](#terminal)
  - [UI Toggles](#ui-toggles)
- [Commands](#commands)
- [Plugins](#plugins)
- [Configuration Structure](#configuration-structure)
- [Customization](#customization)
  - [Adding Plugins](#adding-plugins)
  - [Changing Theme](#changing-theme)
  - [Adding Language Support](#adding-language-support)
  - [Modifying Keybindings](#modifying-keybindings)
- [Troubleshooting](#troubleshooting)
- [Workflows](#workflows)

---

## Installation

### Prerequisites

Before installing, ensure you have the following:

#### Required

| Tool | Minimum Version | Purpose |
|------|-----------------|---------|
| **Neovim** | 0.10.0+ | The editor itself |
| **Git** | 2.19+ | Plugin management |
| **Node.js** | 16+ | LSP servers & tools |
| **npm/pnpm** | Latest | Package installation |

#### Recommended

| Tool | Purpose |
|------|---------|
| **Nerd Font** | Icons display (e.g., JetBrainsMono Nerd Font) |
| **ripgrep** | Fast grep for Telescope |
| **fd** | Fast file finder for Telescope |
| **lazygit** | Git TUI integration |
| **tmux** | Terminal multiplexer integration |

#### Language-Specific (for LSP/Debugging)

| Language | Requirements |
|----------|--------------|
| Python | Python 3.8+, pip |
| Rust | rustc, cargo |
| Go | go 1.18+ |
| Node.js | Already installed |

### Quick Start

#### macOS

```bash
# Install Homebrew if not present
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install neovim node npm ripgrep fd lazygit

# Install a Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Clone or symlink this configuration
# If this is part of your dotfiles:
ln -s /path/to/dotfiles/nvim ~/.config/nvim

# Or clone directly:
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim

# Start Neovim - plugins will auto-install
nvim
```

#### Linux (Ubuntu/Debian)

```bash
# Add Neovim PPA for latest version
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update

# Install dependencies
sudo apt install neovim nodejs npm ripgrep fd-find

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv

# Setup config (same as macOS)
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
ln -s /path/to/dotfiles/nvim ~/.config/nvim
nvim
```

#### Windows (PowerShell)

```powershell
# Install Scoop package manager
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Install dependencies
scoop bucket add extras
scoop install neovim nodejs-lts ripgrep fd lazygit

# Install Nerd Font (manual download recommended)
# Visit: https://www.nerdfonts.com/font-downloads

# Backup existing config
Rename-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak -ErrorAction SilentlyContinue
Rename-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak -ErrorAction SilentlyContinue

# Clone config
git clone https://github.com/yourusername/nvim-config.git $env:LOCALAPPDATA\nvim

# Start Neovim
nvim
```

### Platform-Specific Notes

#### macOS
- Terminal: Use iTerm2, Kitty, or WezTerm for best experience
- Set your terminal font to a Nerd Font variant

#### Linux
- Some distros may have older Neovim; build from source if needed
- Wayland users: Ensure clipboard tools like `wl-copy` are installed

#### Windows
- Use Windows Terminal or a similar modern terminal
- WSL is recommended for best Unix tool compatibility

### Post-Installation

On first launch, Neovim will:

1. **Bootstrap lazy.nvim** - Downloads plugin manager
2. **Install plugins** - All plugins are downloaded
3. **Install LSP servers** - Mason installs configured servers
4. **Install Treesitter parsers** - Language parsers are compiled

This may take a few minutes. Check `:Lazy` for plugin status and `:Mason` for LSP/tool status.

**Verify Installation:**

```vim
:checkhealth          " Check overall health
:Lazy                 " View plugin status
:Mason                " View LSP/tool status
:LspInfo              " Check LSP attachment
:TSInstallInfo        " Check Treesitter parsers
```

---

## Keybindings

**Leader key: `<Space>`**

> 💡 Press `<Space>` and wait to see available commands via which-key.

### General

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Esc>` | Normal | Clear search highlights |
| `<C-s>` | Normal/Insert | Save file |
| `<C-q>` | Normal | Quit |
| `<leader>qq` | Normal | Force quit all |
| `<leader>sn` | Normal | Save without formatting |
| `jk` / `kj` | Insert | Exit insert mode |

### Navigation

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<C-d>` | Normal | Scroll down (centered) |
| `<C-u>` | Normal | Scroll up (centered) |
| `n` / `N` | Normal | Next/prev search result (centered) |
| `j` / `k` | Normal | Move through wrapped lines |
| `s` | Normal | Flash jump |
| `S` | Normal | Flash Treesitter |
| `{` / `}` | Normal | Previous/next code symbol (Aerial) |
| `[[` / `]]` | Normal | Previous/next reference |

### Windows and Splits

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<C-h/j/k/l>` | Normal | Navigate between windows |
| `<leader>sv` | Normal | Split vertical |
| `<leader>sh` | Normal | Split horizontal |
| `<leader>se` | Normal | Equalize splits |
| `<leader>sx` | Normal | Close current split |
| `<C-Up/Down/Left/Right>` | Normal | Resize windows |

### Buffers and Tabs

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Tab>` | Normal | Next buffer |
| `<S-Tab>` | Normal | Previous buffer |
| `<S-h>` | Normal | Previous buffer (alt) |
| `<S-l>` | Normal | Next buffer (alt) |
| `<leader>x` | Normal | Close buffer |
| `<leader>X` | Normal | Force close buffer |
| `<leader>bn` | Normal | New buffer |
| `<leader>bo` | Normal | Close other buffers |
| `<leader>bp` | Normal | Pin buffer |
| `<leader>to` | Normal | Open new tab |
| `<leader>tx` | Normal | Close tab |
| `<leader>tn` / `<leader>tp` | Normal | Next/previous tab |

### File Explorer

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>e` | Normal | Toggle Neo-tree (sidebar) |
| `<leader>w` | Normal | Toggle Neo-tree (floating) |
| `\` | Normal | Reveal file in Neo-tree |
| `-` | Normal | Open Oil (parent directory) |
| `<leader>ge` | Normal | Git status explorer |

**Neo-tree keybindings (inside explorer):**

| Key | Action |
|-----|--------|
| `<CR>` / `l` | Open file |
| `h` | Close node |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `P` | Toggle preview |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `?` | Show help |

### Harpoon (Quick File Access)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>m` | Normal | Add file to Harpoon |
| `<leader>M` | Normal | Open Harpoon menu |
| `<leader>1-5` | Normal | Jump to Harpoon file 1-5 |
| `<leader>hp` | Normal | Previous Harpoon file |
| `<leader>hn` | Normal | Next Harpoon file |

### Telescope

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader><leader>` | Normal | Find buffers |
| `<leader>ff` / `<leader>sf` | Normal | Find files |
| `<leader>fr` / `<leader>so` | Normal | Recent files |
| `<leader>sg` | Normal | Live grep |
| `<leader>sw` | Normal | Search current word |
| `<leader>/` | Normal | Fuzzy search in buffer |
| `<leader>gf` | Normal | Git files |
| `<leader>gc` | Normal | Git commits |
| `<leader>gb` | Normal | Git branches |
| `<leader>gs` | Normal | Git status |
| `<leader>sh` | Normal | Search help |
| `<leader>sk` | Normal | Search keymaps |
| `<leader>sc` | Normal | Search commands |
| `<leader>sd` | Normal | Search diagnostics |
| `<leader>sr` | Normal | Resume last search |
| `<leader>sm` | Normal | Search marks |
| `<leader>st` | Normal | Search TODOs |
| `<leader>ss` | Normal | Document symbols |

**Telescope Navigation (inside picker):**

| Key | Action |
|-----|--------|
| `<C-j>` / `<C-n>` | Next item |
| `<C-k>` / `<C-p>` | Previous item |
| `<CR>` | Select |
| `<C-s>` | Open horizontal split |
| `<C-v>` | Open vertical split |
| `<C-t>` | Open in new tab |
| `<C-q>` | Send to quickfix |
| `q` / `<Esc>` | Close (normal mode) |

### LSP

| Keybinding | Mode | Description |
|------------|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Find references |
| `gI` | Normal | Go to implementation |
| `gy` | Normal | Go to type definition |
| `K` | Normal | Hover documentation |
| `<C-k>` | Insert | Signature help |
| `<leader>cr` | Normal | Rename symbol |
| `<leader>ca` | Normal/Visual | Code action |
| `<leader>cf` | Normal/Visual | Format code |
| `<leader>ds` | Normal | Document symbols |
| `<leader>ws` | Normal | Workspace symbols |
| `<leader>wa` | Normal | Add workspace folder |
| `<leader>wr` | Normal | Remove workspace folder |
| `<leader>wl` | Normal | List workspace folders |
| `[d` / `]d` | Normal | Previous/next diagnostic |
| `<leader>cd` | Normal | Show diagnostic float |
| `<leader>cq` | Normal | Diagnostics to quickfix |
| `<leader>cm` | Normal | Open Mason |

### Git

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>lg` | Normal | Open LazyGit |
| `<leader>gg` | Normal | Git status (Fugitive) |
| `<leader>gd` | Normal | Git diff split |
| `<leader>gp` | Normal | Git push |
| `<leader>gl` | Normal | Git pull |
| `<leader>gB` | Normal | Git blame file |
| `<leader>gv` | Normal | Open Diffview |
| `<leader>gV` | Normal | Close Diffview |
| `<leader>gh` | Normal | File history |
| `<leader>gH` | Normal | Repo history |
| `]h` / `[h` | Normal | Next/previous hunk |
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |
| `<leader>hB` | Normal | Toggle line blame |
| `<leader>hd` | Normal | Diff this |
| `ih` | Operator | Select hunk (text object) |

### Debugging

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<F5>` | Normal | Start/Continue debugging |
| `<F10>` | Normal | Step over |
| `<F11>` | Normal | Step into |
| `<F12>` | Normal | Step out |
| `<leader>db` | Normal | Toggle breakpoint |
| `<leader>dB` | Normal | Conditional breakpoint |
| `<leader>dc` | Normal | Continue |
| `<leader>dC` | Normal | Run to cursor |
| `<leader>di` | Normal | Step into |
| `<leader>do` | Normal | Step out |
| `<leader>dO` | Normal | Step over |
| `<leader>dp` | Normal | Pause |
| `<leader>dr` | Normal | Toggle REPL |
| `<leader>ds` | Normal | Session info |
| `<leader>dt` | Normal | Terminate |
| `<leader>du` | Normal | Toggle DAP UI |
| `<leader>de` | Normal/Visual | Evaluate expression |
| `<leader>dw` | Normal | Hover widgets |
| `<leader>dl` | Normal | Run last |
| `<leader>dj` / `<leader>dk` | Normal | Down/Up in stack |
| `<leader>dg` | Normal | Go to line |

### Editing

| Keybinding | Mode | Description |
|------------|------|-------------|
| `x` | Normal | Delete char (no yank) |
| `<leader>d` | Normal/Visual | Delete (no yank) |
| `<leader>y` | Normal/Visual | Yank to clipboard |
| `<leader>Y` | Normal | Yank line to clipboard |
| `p` | Visual | Paste (no yank) |
| `J` | Normal | Join lines (keep cursor) |
| `<` / `>` | Visual | Indent (stay in mode) |
| `<A-j>` / `<A-k>` | Normal/Visual/Insert | Move line(s) up/down |
| `<leader>dl` | Normal | Duplicate line |
| `<leader>rw` | Normal | Replace word under cursor |
| `<leader>j` | Normal | Replace word (repeatable) |
| `<leader>=` / `<leader>-` | Normal | Increment/decrement number |
| `gcc` | Normal | Toggle comment line |
| `gc` | Visual/Operator | Toggle comment |
| `gbc` | Normal | Toggle block comment |
| `<C-/>` | Normal/Visual | Toggle comment |
| `<leader>sr` | Normal | Search and replace (Spectre) |

**Surround (nvim-surround):**

| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |

**Text Objects (Treesitter):**

| Key | Description |
|-----|-------------|
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class |
| `aa` / `ia` | Around/inside argument |
| `al` / `il` | Around/inside loop |
| `ai` / `ii` | Around/inside conditional |
| `ab` / `ib` | Around/inside block |

**Movement (Treesitter):**

| Key | Description |
|-----|-------------|
| `]f` / `[f` | Next/prev function start |
| `]c` / `[c` | Next/prev class start |
| `]a` / `[a` | Next/prev argument |
| `<leader>a` | Swap next argument |
| `<leader>A` | Swap previous argument |

### Terminal

| Keybinding | Mode | Description |
|------------|------|-------------|
| `` <C-`> `` | Normal/Terminal | Toggle terminal |
| `<leader>tt` | Normal | Floating terminal |
| `<leader>th` | Normal | Horizontal terminal |
| `<leader>tv` | Normal | Vertical terminal |
| `<Esc>` / `jk` | Terminal | Exit terminal mode |
| `<C-h/j/k/l>` | Terminal | Navigate windows |

### UI Toggles

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ut` | Normal | Toggle transparency |
| `<leader>ud` | Normal | Toggle diagnostics |
| `<leader>uf` | Normal | Toggle format on save |
| `<leader>uh` | Normal | Toggle inlay hints |
| `<leader>uc` | Normal | Toggle Treesitter context |
| `<leader>un` | Normal | Dismiss notifications |
| `<leader>uw` | Normal | Toggle word wrap |
| `<leader>ur` | Normal | Toggle relative numbers |
| `<leader>us` | Normal | Toggle spell check |
| `<leader>ul` | Normal | Toggle list characters |
| `<leader>uu` | Normal | Toggle Undotree |
| `<leader>o` | Normal | Toggle code outline (Aerial) |

### Session

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ss` | Normal | Save session |
| `<leader>sl` | Normal | Load session |

### Quickfix/Trouble

| Keybinding | Mode | Description |
|------------|------|-------------|
| `[q` / `]q` | Normal | Previous/next quickfix |
| `<leader>co` | Normal | Open quickfix |
| `<leader>cc` | Normal | Close quickfix |
| `<leader>xx` | Normal | Toggle Trouble diagnostics |
| `<leader>xX` | Normal | Buffer diagnostics (Trouble) |
| `<leader>xl` | Normal | Location list (Trouble) |
| `<leader>xq` | Normal | Quickfix list (Trouble) |
| `<leader>cs` | Normal | Symbols (Trouble) |

---

## Commands

### Custom Commands

| Command | Description |
|---------|-------------|
| `:FormatDisable` | Disable format on save (global) |
| `:FormatDisable!` | Disable format on save (buffer) |
| `:FormatEnable` | Enable format on save |
| `:Mason` | Open Mason package manager |
| `:Lazy` | Open Lazy plugin manager |
| `:LazyGit` | Open LazyGit |
| `:Telescope <picker>` | Open Telescope with picker |
| `:Neotree` | Toggle Neo-tree |
| `:Oil` | Open Oil file manager |
| `:ConformInfo` | Show formatter info |
| `:LspInfo` | Show LSP info |
| `:TSInstall <lang>` | Install Treesitter parser |
| `:checkhealth` | Check Neovim health |

### Useful Built-in Commands

| Command | Description |
|---------|-------------|
| `:e <file>` | Edit file |
| `:w` | Save file |
| `:q` / `:qa` | Quit / Quit all |
| `:wq` | Save and quit |
| `:vs` / `:sp` | Vertical/horizontal split |
| `:bn` / `:bp` | Next/previous buffer |
| `:bd` | Delete buffer |
| `:%s/old/new/gc` | Search and replace |
| `:noh` | Clear search highlight |
| `:set <option>?` | Check option value |
| `:help <topic>` | Open help |

---

## Plugins

### Core

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua functions library |

### LSP & Completion

| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/Linter installer |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress |

### Syntax & Languages

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Text objects |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | Sticky context |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto close HTML tags |

### Navigation

| Plugin | Description |
|--------|-------------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File manager as buffer |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Quick file access |
| [flash.nvim](https://github.com/folke/flash.nvim) | Navigation motions |

### Git

| Plugin | Description |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Diff viewer |

### UI

| Plugin | Description |
|--------|-------------|
| [catppuccin](https://github.com/catppuccin/nvim) | Color scheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI enhancements |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notifications |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | Better UI |

### Editing

| Plugin | Description |
|--------|-------------|
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Commenting |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround motions |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto pairs |
| [mini.ai](https://github.com/echasnovski/mini.ai) | Better text objects |
| [vim-sleuth](https://github.com/tpope/vim-sleuth) | Auto detect indent |

### Debugging

| Plugin | Description |
|--------|-------------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Debugger UI |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go debugging |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debugging |

### Other

| Plugin | Description |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) | Linting |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO highlighting |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Code outline |
| [undotree](https://github.com/mbbill/undotree) | Undo history |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal |
| [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) | Search & replace |
| [vim-illuminate](https://github.com/RRethy/vim-illuminate) | Highlight words |
| [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | Color highlighting |

---

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── core/
│   │   ├── init.lua           # Load core modules
│   │   ├── options.lua        # Editor options
│   │   ├── keymaps.lua        # Key mappings
│   │   ├── autocmds.lua       # Autocommands
│   │   └── diagnostics.lua    # Diagnostic settings
│   └── plugins/
│       ├── init.lua           # Plugin index
│       ├── themes.lua         # Color schemes
│       ├── lsp.lua            # LSP configuration
│       ├── completion.lua     # Autocompletion
│       ├── treesitter.lua     # Syntax highlighting
│       ├── formatting.lua     # Formatters/linters
│       ├── telescope.lua      # Fuzzy finder
│       ├── navigation.lua     # File navigation
│       ├── git.lua            # Git integration
│       ├── ui.lua             # UI components
│       ├── editor.lua         # Editor enhancements
│       └── debug.lua          # Debugging
└── README.md                   # This file
```

---

## Customization

### Adding Plugins

Create a new file in `lua/plugins/` or add to existing file:

```lua
-- lua/plugins/my-plugins.lua
return {
  {
    'username/plugin-name',
    event = 'VeryLazy',  -- or other lazy loading event
    opts = {
      -- plugin options
    },
    config = function(_, opts)
      require('plugin-name').setup(opts)
    end,
  },
}
```

Then add to `lua/plugins/init.lua`:

```lua
{ import = 'plugins.my-plugins' },
```

### Changing Theme

Edit `lua/plugins/themes.lua` or change in init.lua:

```lua
-- Available themes: catppuccin, tokyonight, nord, onedark, kanagawa, rose-pine

-- To switch theme, change the colorscheme command:
vim.cmd.colorscheme 'tokyonight'
```

Or switch at runtime:
```vim
:colorscheme tokyonight
```

### Adding Language Support

1. **Add LSP server** in `lua/plugins/lsp.lua`:

```lua
local servers = {
  -- Add your server here
  your_server = {
    settings = {
      -- Server-specific settings
    },
  },
}
```

2. **Add Treesitter parser** in `lua/plugins/treesitter.lua`:

```lua
ensure_installed = {
  'your_language',
  -- ...
}
```

3. **Add formatter** in `lua/plugins/formatting.lua`:

```lua
formatters_by_ft = {
  your_language = { 'your_formatter' },
}
```

### Modifying Keybindings

**Global keymaps:** Edit `lua/core/keymaps.lua`

```lua
vim.keymap.set('n', '<leader>xx', '<cmd>SomeCommand<CR>', { desc = 'Description' })
```

**Plugin-specific:** Edit the plugin's file in `lua/plugins/`

---

## Troubleshooting

### Common Issues

#### Plugins not installing

```vim
:Lazy sync
:Lazy clean
:Lazy update
```

#### LSP not attaching

1. Check server is installed: `:Mason`
2. Check status: `:LspInfo`
3. Check logs: `:LspLog`

#### Treesitter errors

```vim
:TSUpdate
:TSInstall! <language>
```

#### Icons not displaying

- Ensure you have a Nerd Font installed
- Set your terminal font to the Nerd Font variant

#### Slow startup

1. Check startup time: `nvim --startuptime startup.log`
2. Profile with `:Lazy profile`
3. Consider lazy loading more plugins

#### Mason install failures

1. Ensure Node.js and npm are installed
2. Check network connectivity
3. Try `:MasonLog` for details

### Health Checks

Run comprehensive health check:

```vim
:checkhealth
```

Check specific areas:
```vim
:checkhealth lazy
:checkhealth nvim-treesitter
:checkhealth lspconfig
```

### Reset Configuration

```bash
# Backup first!
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Restart Neovim - plugins will reinstall
nvim
```

---

## Workflows

### Opening a Project

```bash
cd your-project
nvim .
```

Or use Telescope to find and open files directly:
1. `<leader>ff` - Find file
2. `<leader>sg` - Search in project

### Code Navigation

1. **Go to definition:** `gd`
2. **Find references:** `gr`
3. **Symbol search:** `<leader>ss` (document) or `<leader>ws` (workspace)
4. **File outline:** `<leader>o`

### Making Changes

1. **Quick edit:** Use flash (`s`) to jump anywhere
2. **Multi-cursor-like:** `<leader>j` to replace word (repeatable with `.`)
3. **Project-wide replace:** `<leader>sr` (Spectre)
4. **Format code:** `<leader>cf` or save (auto-format)

### Git Workflow

1. **Open LazyGit:** `<leader>lg` (full Git UI)
2. **Stage hunks:** `<leader>hs` (in Neo-tree)
3. **View diff:** `<leader>gv` (Diffview)
4. **Blame:** `<leader>hb`

### Debugging

1. **Set breakpoint:** `<leader>db`
2. **Start debugging:** `<F5>`
3. **Step through:** `<F10>` (over), `<F11>` (into), `<F12>` (out)
4. **Inspect variables:** Hover or use DAP UI

### File Management

1. **Tree view:** `<leader>e`
2. **Quick files:** Harpoon (`<leader>m` to mark, `<leader>1-5` to jump)
3. **Oil editing:** `-` to open parent as buffer

---

## License

MIT

---

<div align="center">

**Happy coding!** 🚀

</div>

