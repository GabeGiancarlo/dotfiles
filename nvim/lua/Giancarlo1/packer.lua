return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd [[colorscheme tokyonight]]  -- Correctly load colorscheme AFTER installation
        end
    }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground' -- Corrected typo
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use({'neovim/nvim-lspconfig'})
    use({'hrsh7th/nvim-cmp'})
    use({'hrsh7th/cmp-nvim-lsp'})
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                plugins = {
                    marks = true, -- Show marks
                    registers = true, -- Show registers
                },
                key_labels = {
                    ["<leader>"] = "SPC", -- Change leader key label
                },
            }
        end
    }
    use({
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",   -- UI components
            "rcarriga/nvim-notify",   -- Notification system (optional but recommended)
        }
    })
end)
