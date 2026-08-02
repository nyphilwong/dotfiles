return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  config = function ()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "lua", "python", "javascript",
        "sql",                          -- SQL files
        "bash",                         -- shell scripts
        "json", "yaml", "toml",         -- config files
        "markdown", "markdown_inline",  -- for keymaps.md and docs
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
