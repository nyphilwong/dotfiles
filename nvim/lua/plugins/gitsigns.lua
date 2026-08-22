return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      -- Word-level (not just line-level) highlighting within changed lines
      word_diff = false, -- toggle live inline word diff with <leader>gw below
      current_line_blame = false,

      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, key, fn, desc)
          vim.keymap.set(mode, key, fn, { buffer = bufnr, desc = "Git: " .. desc })
        end

        -- Jump between hunks
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, "Next hunk")

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, "Previous hunk")

        -- Inline diff preview: shows removed lines as virtual text right
        -- above the change, in place -- no split window.
        map("n", "<leader>gp", gs.preview_hunk_inline, "Preview hunk inline")

        -- Live word-level diff highlighting toggle
        map("n", "<leader>gw", gs.toggle_word_diff, "Toggle word diff")

        -- Stage/reset/blame
        map("n", "<leader>gs", gs.stage_hunk,   "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk,   "Reset hunk")
        map("n", "<leader>gb", gs.blame_line,   "Blame line")
      end,
    })
  end,
}
