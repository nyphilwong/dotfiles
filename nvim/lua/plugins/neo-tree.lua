return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", 
  },
  lazy = false,
  config = function ()
    local config = require("neo-tree")
    config.setup({
      filesystem = {
        filtered_items = {
          hide_dotfiels = false,
          visible = true
        },
        use_libuv_file_watcher = true,
      }
    })
    -- <leader>e is the primary toggle (set in core/keymaps.lua)
    -- Keep <C-n> as a reveal shortcut (focuses the current file in the tree)
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', { desc = "Reveal file in explorer" })
  end
}
