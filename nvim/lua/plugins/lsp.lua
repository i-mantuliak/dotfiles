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
        ensure_installed = { "pyright", "pylsp", "ruff", "lua_ls" },
        automatic_installation = true,
        automatic_enable = true,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
        end
        bufmap("n", "gd", vim.lsp.buf.definition)
        bufmap("n", "K", vim.lsp.buf.hover)
        bufmap("n", "gr", vim.lsp.buf.references)
        bufmap("n", "<leader>rn", vim.lsp.buf.rename)
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
        bufmap("n", "<leader>f", function() vim.lsp.buf.format { async = true } end)
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

      -- python venv helper
      local function get_python_path(workspace)
        if vim.env.VIRTUAL_ENV then
          return vim.env.VIRTUAL_ENV .. "/bin/python"
        end
        local venv_path = workspace .. "/.venv/bin/python"
        if vim.fn.executable(venv_path) == 1 then
          return venv_path
        end
        return "python3"
      end

      -- pylsp
      vim.lsp.config("pylsp", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = true },
              pycodestyle = { enabled = false },
              black = { enabled = true },
              isort = { enabled = false },
              pylsp_mypy = { enabled = true, live_mode = false },
              jedi = {
                environment = get_python_path(vim.fn.getcwd()),
              },
            },
          },
        },
      })

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
    end,
  },
}
