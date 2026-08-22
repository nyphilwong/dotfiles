return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    require("lualine").setup({
      options = {
        theme = 'auto'
      },
      sections = {
        lualine_b = {
          'branch',
          {
            -- Default 'diff' runs its own `git diff` job that only
            -- re-runs on BufEnter/BufWritePost, so it goes stale after
            -- committing elsewhere. Read gitsigns' live-watched status
            -- instead -- it stays in sync with .git automatically.
            'diff',
            source = function()
              local gs = vim.b.gitsigns_status_dict
              if gs then
                return { added = gs.added, modified = gs.changed, removed = gs.removed }
              end
            end,
          },
          'diagnostics',
        },
      },
    })
  end
}
