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
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons" -- Provides icons
  use "kyazdani42/nvim-tree.lua" -- File explorer for neovim
  use "moll/vim-bbye" -- Delete buffers without closing windows
  use "nvim-lualine/lualine.nvim" -- Lua statusline at bottom
  use "ahmedkhalf/project.nvim" -- Project Management
  use "lewis6991/impatient.nvim" -- Improve startup time for Neovim
  use "lukas-reineke/indent-blankline.nvim" -- Can add indentation lines
  use "goolord/alpha-nvim" -- Nvim Greeter
  use "ap/vim-css-color" -- Preview HEX colors
  use "antoinemadec/FixCursorHold.nvim" -- Fix lsp doc highlight
  use "folke/which-key.nvim" -- Popup that shows possible key combinations

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use "dracula/vim"
  use "morhetz/gruvbox"
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- LSP completions
  use "hrsh7th/cmp-nvim-lua" -- Lua completions

  -- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim" --fuzzy file finding + more
  use "nvim-telescope/telescope-media-files.nvim" -- view media files in telescope

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter", -- better syntax highlighting
    run = ":TSUpdate",
    "p00f/nvim-ts-rainbow", -- rainbow bracket colorizing
    }

  use "JoosepAlviste/nvim-ts-context-commentstring" -- gcc command is context-aware

  -- Git
  use "lewis6991/gitsigns.nvim" -- git symbols + commands

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
