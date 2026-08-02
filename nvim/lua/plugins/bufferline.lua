return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        -- Show buffer numbers in the tab bar
        numbers = "ordinal",
        -- Mouse click on a tab switches to that buffer
        -- (enabled by default when mouse is on)
        -- Close button on each tab
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        -- Show diagnostics icons in the tab (LSP errors/warnings)
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        -- Don't show neo-tree or other non-file buffers as tabs
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        -- Show file icons (requires nvim-web-devicons + Nerd Font)
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "thin",
      },
    })

    -- Shift+L / Shift+H are already mapped in keymaps.lua (bnext/bprevious)
    -- These additional keymaps let you jump directly to a tab by number
    local map = vim.keymap.set
    map("n", "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Buffer: Go to 1" })
    map("n", "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Buffer: Go to 2" })
    map("n", "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Buffer: Go to 3" })
    map("n", "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Buffer: Go to 4" })
    map("n", "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Buffer: Go to 5" })
  end,
}
