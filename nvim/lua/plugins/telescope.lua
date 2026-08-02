return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin   = require("telescope.builtin")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "__pycache__",
          ".venv",
        },
      },
    })

    telescope.load_extension("fzf")

    local map = vim.keymap.set

    -- File finding
    map("n", "<C-p>",      builtin.find_files,  { desc = "Search: Find files" })
    map("n", "<leader>sf", builtin.find_files,  { desc = "Search: Find files" })
    map("n", "<leader>sg", builtin.live_grep,   { desc = "Search: Grep in files" })
    map("n", "<leader>sb", builtin.buffers,     { desc = "Search: Open buffers" })
    map("n", "<leader>sr", builtin.oldfiles,    { desc = "Search: Recent files" })
    map("n", "<leader>sh", builtin.help_tags,   { desc = "Search: Help tags" })

    -- LSP-powered search (available after Phase 3)
    map("n", "<leader>ss", builtin.lsp_document_symbols,  { desc = "Search: Symbols in file" })
    map("n", "<leader>sS", builtin.lsp_workspace_symbols, { desc = "Search: Symbols in workspace" })
  end,
}
