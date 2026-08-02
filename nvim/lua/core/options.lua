-- Line numbers
vim.wo.number = true
vim.o.relativenumber = true

-- Indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- Appearance
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.wrap = false

-- Splits open in natural directions
vim.o.splitright = true
vim.o.splitbelow = true

-- Persistent undo (survives closing Neovim)
vim.o.undofile = true

-- Use macOS system clipboard for all yank/paste operations
vim.o.clipboard = "unnamedplus"

-- Faster sign/diagnostic updates (gitsigns, LSP)
vim.o.updatetime = 250
