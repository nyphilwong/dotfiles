-- Using the `main` branch, not `master`: `master` is a frozen legacy branch
-- kept only for Neovim <=0.11 compatibility and crashes on injections
-- (e.g. fenced code blocks in markdown) against newer Neovim cores like
-- 0.12. `main` is the branch actively maintained for current Neovim, but
-- its config API is different: parsers/queries are handled by this plugin,
-- while enabling highlighting/indent per filetype is done via core Neovim.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "lua", "python", "javascript",
      "sql",                          -- SQL files
      "bash",                         -- shell scripts
      "json", "yaml", "toml",         -- config files
      "markdown", "markdown_inline",  -- for keymaps.md and docs
    }

    require("nvim-treesitter").setup({})
    require("nvim-treesitter").install(parsers)

    -- markdown_inline has no filetype of its own (only used via injection
    -- into markdown buffers), so it's excluded from this filetype list.
    local filetypes = { "lua", "python", "javascript", "sql", "sh", "json", "yaml", "toml", "markdown" }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
