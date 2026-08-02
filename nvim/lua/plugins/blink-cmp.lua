return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"]   = { "accept", "fallback" },
      ["<C-n>"]   = { "select_next", "fallback" },
      ["<C-p>"]   = { "select_prev", "fallback" },
      ["<C-e>"]   = { "cancel" },
    },
    appearance = {
      -- Matches JetBrains Mono Nerd Font
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "buffer" },
      -- lsp:    completions from pyright / ruff / sqls
      -- path:   file path completions (useful for imports)
      -- buffer: words already present in open files
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
  },
}
