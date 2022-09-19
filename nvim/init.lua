require('ava')
require'nvim-treesitter.configs'.setup {
    context_commentstring = {
        enable = true
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    }
}

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'tpope/vim-commentary'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'lukas-reineke/indent-blankline.nvim'
    use "neovim/nvim-lspconfig"
    use 'williamboman/nvim-lsp-installer'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {"nvim-telescope/telescope-file-browser.nvim"}
    use {
        "ur4ltz/surround.nvim",
        config = function()
            require"surround".setup {
                mappings_style = "surround"
            }
        end
    }
    use 'tpope/vim-fugitive'
    use 'ThePrimeagen/vim-be-good'
    use 'lewis6991/gitsigns.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'onsails/lspkind-nvim'
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
end)
