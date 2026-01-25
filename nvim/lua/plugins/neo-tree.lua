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
      }
    })
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
  end
}
