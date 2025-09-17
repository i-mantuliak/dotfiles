return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "pyright", "ruff", "lua_ls", "helm_ls" },
        automatic_installation = true,
        automatic_enable = true,
      }
    end,
  },
  -- helm syntax highlighting
  { "towolf/vim-helm" },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
        end

        -- LSP keymaps
        bufmap("n", "gd", vim.lsp.buf.definition)
        bufmap("n", "K", vim.lsp.buf.hover)
        bufmap("n", "gr", vim.lsp.buf.references)
        bufmap("n", "<leader>rn", vim.lsp.buf.rename)
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
        bufmap("n", "<leader>f", function() vim.lsp.buf.format { async = true } end)

        -- diagnostics popup
        local function show_diagnostics()
          local win_id = vim.diagnostic.open_float(nil, { focus = false })
          vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave" }, {
            once = true,
            buffer = vim.api.nvim_get_current_buf(),
            callback = function()
              if vim.api.nvim_win_is_valid(win_id) then
                vim.api.nvim_win_close(win_id, true)
              end
            end,
          })
        end
        bufmap("n", "<leader>e", show_diagnostics)
      end

      -- pyright
      vim.lsp.config("pyright", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- ruff
      vim.lsp.config("ruff", {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

      -- lua_ls
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- helm_ls
      vim.lsp.config("helm_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["helm-ls"] = { yamlls = { enabled = true } },
        },
      })

      -- Helm filetypes
      vim.filetype.add {
        extension = {
          tpl = "helm",
        },
        filename = {
          ["values.yaml"] = "helm",
          ["values.yml"] = "helm",
        },
        pattern = {
          -- всё, что в папке templates/ у чарта
          [".*/templates/.*%.yaml"] = "helm",
          [".*/templates/.*%.yml"] = "helm",
        },
      }

    end,
  },
}
