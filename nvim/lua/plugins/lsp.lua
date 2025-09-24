return {
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    config = true,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'pyright',
          'ruff',
          'lua_ls',
          'bashls',
          'helm_ls',
          'kotlin_language_server',
        },
        automatic_installation = true,
        automatic_enable = true,
      }
    end,
  },
  -- helm syntax highlighting
  { 'towolf/vim-helm' },
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    config = function()
      require('lsp_signature').setup {
        bind = true,
        hint_enable = false,
        floating_window = true,
        handler_opts = { border = 'rounded' },
        toggle_key = '<C-s>',
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(_, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
        end

        -- LSP keymaps
        bufmap('n', 'gd', vim.lsp.buf.definition)
        bufmap('n', 'K', vim.lsp.buf.hover)
        bufmap('n', 'gr', vim.lsp.buf.references)
        bufmap('n', '<leader>rn', vim.lsp.buf.rename)
        bufmap('n', '<leader>ca', vim.lsp.buf.code_action)
        bufmap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end)
        bufmap('n', '<leader>e', vim.diagnostic.open_float)
        bufmap('n', '<leader>q', vim.diagnostic.setloclist)

        vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = false,
        })
      end

      local get_python_path = require('core.helpers').get_python_path

      -- pyright
      vim.lsp.config('pyright', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            pythonPath = get_python_path(vim.fn.getcwd()),
            venvPath = '.',
            venv = '.venv',
          },
        },
      })

      -- ruff
      vim.lsp.config('ruff', {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

      -- lua_ls
      vim.lsp.config('lua_ls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- helm_ls
      vim.lsp.config('helm_ls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ['helm-ls'] = { yamlls = { enabled = true } },
        },
      })

      -- Bash LSP
      vim.lsp.config('bashls', {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'sh', 'bash', 'zsh' },
      })

      -- Kotlin LSP
      vim.lsp.config('kotlin_language_server', {
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
