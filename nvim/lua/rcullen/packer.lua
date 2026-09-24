vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        tag = 'v3.0.2',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use({
        'windwp/nvim-ts-autotag',
        requires = { { 'nvim-treesitter' } },
        config = function() require('nvim-ts-autotag').setup() end
    })
    -- use('nvim-treesitter/playground')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use({
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup()
        end
    })
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" }
    })
    use({
        'nvim-mini/mini.nvim',
        config = function()
            require('mini.comment').setup()
        end
    })
    use({
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require("nvim-autopairs").setup({})
        end
    })
    use('elihunter173/dirbuf.nvim')

    use({
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    })

    use({
        'lervag/vimtex',
        tag = 'v2.18',
        config = function()
            vim.g.vimtex_view_method = 'open'
            vim.g.vimtex_compiler_latexmk_engines = { '_', 'lualatex' }
        end
    })
end)
