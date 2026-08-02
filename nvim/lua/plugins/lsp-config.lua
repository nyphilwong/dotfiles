return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", config = true },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- ── Auto-install language servers and tools via Mason ─────────────────
    -- sqls (SQL LSP) requires Go to build — install separately with:
    --   brew install sqls
    -- then it will be picked up automatically via lspconfig below.
    require("mason-tool-installer").setup({
      ensure_installed = {
        "pyright",   -- Python: type checking, go-to-definition, hover docs
        "ruff",      -- Python: linting + formatting
        "lua_ls",    -- Lua: for editing this Neovim config
        "stylua",    -- Lua formatter
      },
    })

    -- ── LSP keymaps (only active in buffers where an LSP is running) ──────
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition,  "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gr", vim.lsp.buf.references,  "Find references")
        map("K",  vim.lsp.buf.hover,       "Hover documentation")

        map("<leader>rn", vim.lsp.buf.rename,      "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>f",  vim.lsp.buf.format,      "Format file")
      end,
    })

    -- ── Server configurations (native vim.lsp.config, Neovim 0.11+) ──────
    vim.lsp.config("pyright", {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoImportCompletions = true,
          },
        },
      },
    })

    vim.lsp.config("ruff", {})

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- sqls: only enable if installed (brew install sqls)
    if vim.fn.executable("sqls") == 1 then
      vim.lsp.config("sqls", {})
      vim.lsp.enable("sqls")
    end

    -- Enable all configured servers
    vim.lsp.enable({ "pyright", "ruff", "lua_ls" })
  end,
}
