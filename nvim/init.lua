vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.g.mapleader=" "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin"},
  { "projekt0n/github-nvim-theme", name = "github-theme"},
  {
    'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
     dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", 
    },
    lazy = false,
  }
}
local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- needs ripgrep (brew install ripgrep)

vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "vim", "python", "javascript"},
  highlight = {enable = true},
  indent = {enable = true}
})

local theme = require("github-theme")
theme.setup({
  options = {
    styles = { comments = 'italic' },
    modules = {
      treesitter = true,
    }
  }
})
vim.cmd.colorscheme "github_dark_dimmed"
