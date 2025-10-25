local servers = {
  "pyright",
  "ruff",
  "lua_ls",
  "bashls",
  "helm_ls",
  "kotlin_language_server",
}

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  callback = function(args)
    local bufnr = args.buf
    -- local opts = { buffer = bufnr }
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    bufmap('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
    bufmap('n', 'gd', vim.lsp.buf.definition, "Go to definition")
    bufmap('n', 'K', vim.lsp.buf.hover, "Show documentation for what is under cursor")
    bufmap('n', 'gi', vim.lsp.buf.implementation, "Go to implementations")
    bufmap('n', '<C-k>', vim.lsp.buf.signature_help, " ")
    bufmap('n', '<leader>rn', vim.lsp.buf.rename, "Smart rename")
    bufmap('n', 'gr', vim.lsp.buf.references, "Go to references")
    bufmap('n', '<leader>ca', vim.lsp.buf.code_action, "See available code actions")
    bufmap('n', '[d', vim.diagnostic.goto_prev, "Go to previous diagnostic")
    bufmap('n', ']d', vim.diagnostic.goto_next, "Go to next diagnostic")
    bufmap("n", "<leader>df", vim.diagnostic.open_float, "Show line diagnostics")
    bufmap('n', '<leader>dl', vim.diagnostic.setloclist, "Show list of diagnostics")
    bufmap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  end,
})

return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = { ensure_installed = servers, },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      for _, server in ipairs(servers) do
        require("lspconfig")[server].setup({
          capabilities = require('blink.cmp').get_lsp_capabilities()
        })
      end
    end,
  },
  -- vim.lsp.enable(servers)
}
