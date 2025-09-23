return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Указываем директорию для парсеров
    local parser_install_dir = vim.fn.stdpath("data") .. "/parsers"

    -- Добавляем путь к парсерам в runtimepath (правильно!)
    vim.opt.runtimepath:append(parser_install_dir)

    require("nvim-treesitter.configs").setup({
      parser_install_dir = parser_install_dir,
      prefer_git = true,
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "python", "javascript", "typescript", "html", "css",
        "json", "yaml", "markdown", "bash", "rust", "go",
      },
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end,
}
