local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" } -- Autopairs, integrates with both cmp and nvim-treesitter
  use "numTostr/comment.nvim"
  use "kyazdani42/nvim-web-devicons"
  -- nvim-tree 
  use { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" }

  --Markdown preview
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

-- buffer plugins
 use "akinsho/bufferline.nvim"
 use "moll/vim-bbye"

  --colorschemes
  use 'folke/tokyonight.nvim'
  use "rebelot/kanagawa.nvim"
--use 'marko-cerovac/material.nvim'

  --cmp plugins
  use "hrsh7th/nvim-cmp" -- the completion plugin
  use "hrsh7th/cmp-buffer" -- buffer plugin
  use "hrsh7th/cmp-path" -- path completion
  use "hrsh7th/cmp-cmdline" --cmdline completion
  use "saadparwaiz1/cmp_luasnip" -- snippet completion
  use "hrsh7th/cmp-nvim-lsp" -- lsp auto completion 
  use "hrsh7th/cmp-nvim-lua" -- nvim configuration cmp 


  --snippets
  use "L3MON4D3/luaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP 
  use "neovim/nvim-lspconfig" -- enable lsp
  --use "williamboman/nvim-lsp-installer" -- language server installer 
  use { "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12"} -- simple to use language server installer
  use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
--use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
  use "nvimtools/none-ls.nvim"
  use { "RRethy/vim-illuminate", commit = "d6ca7f77eeaf61b3e6ce9f0e5a978d606df44298" }
  --use " lukas-reineke/lsp-format.nvim "
  use "lukas-reineke/lsp-format.nvim"

-- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3', }
  use "nvim-telescope/telescope-media-files.nvim"

  --treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		commit = "226c1475a46a2ef6d840af9caa0117a439465500",
	}
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "HiPhish/nvim-ts-rainbow2"
	-- Git
	use "lewis6991/gitsigns.nvim"


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

