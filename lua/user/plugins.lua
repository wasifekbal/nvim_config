local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer, close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")

    -- Colorschemes
    use("Mofiqul/dracula.nvim")
    use("sainnhe/everforest")
    --[[ use({ "ellisonleao/gruvbox.nvim" }) ]]
    use("catppuccin/nvim")

    -- cmp
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp")

    -- snippets.
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")
    use({
        "dsznajder/vscode-es7-javascript-react-snippets",
        run = "yarn install --frozen-lockfile && yarn compile",
    })

    -- lsp
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")

    -- telescope
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-media-files.nvim")

    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("p00f/nvim-ts-rainbow")

    -- nvim-tree
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
    })

    -- comments
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- bufferline
    use({ "akinsho/bufferline.nvim", tag = "v2.*" })

    -- lualine
    use({
        "nvim-lualine/lualine.nvim",
    })

    -- code formatter
    use("sbdchd/neoformat")

    -- code-runner
    use({ "CRAG666/code_runner.nvim", requires = "nvim-lua/plenary.nvim" })

    -- impatient (speed loading lua modules)
    use("lewis6991/impatient.nvim")

    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")

    -- Alpha dashboard
    use("goolord/alpha-nvim")

    -- projects manage
    use("ahmedkhalf/project.nvim")

    -- gitsigns
    use("lewis6991/gitsigns.nvim")

    use("Shatur/neovim-session-manager")

    use({ "akinsho/toggleterm.nvim", tag = "v2.*" })

    use("ThePrimeagen/vim-be-good")

    --[[ color highlighter for Neovim ]]
    use('norcalli/nvim-colorizer.lua')

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
