vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- ─── Windows: move between splits ────────────────────────────────────────────
-- Ctrl+hjkl moves focus between Neovim splits (same keys used for tmux panes)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ─── Windows: resize splits ───────────────────────────────────────────────────
map("n", "<A-Up>",    "<cmd>resize +2<cr>",          { desc = "Increase window height" })
map("n", "<A-Down>",  "<cmd>resize -2<cr>",          { desc = "Decrease window height" })
map("n", "<A-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ─── Buffers ──────────────────────────────────────────────────────────────────
-- Shift+L / Shift+H cycle through open buffers (like browser tab switching)
map("n", "<S-l>", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- ─── File explorer ────────────────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- ─── Editing ──────────────────────────────────────────────────────────────────
-- Stay in visual mode after indenting a selection
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up or down
map("v", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("v", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Clear search highlights with Escape in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Save from normal, insert, and visual mode
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- ─── Diagnostics (LSP errors and warnings) ───────────────────────────────────
map("n", "[d", vim.diagnostic.goto_prev,  { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic detail" })
