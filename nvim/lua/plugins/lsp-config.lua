return {
  "neovim/nvim-lspconfig", 
  dependencies = {
    { "mason-org/mason.nvim", config = true },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  config = function ()
    -- Install LSPs below
    local servers = {
      lua_ls = {},
      pylsp = {},
    }
    
    -- Ensure the servers/tools are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {"stylua"})
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
  end
}
