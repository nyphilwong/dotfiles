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

-- Auto-reload files changed on disk by another editor (only when the
-- buffer itself has no unsaved changes -- a real conflict still prompts).
vim.o.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  desc = "Check for external file changes and reload if unmodified",
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})
