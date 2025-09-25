require 'core.keymaps'
require 'core.options'
require 'core.lazy'
require 'core.autocmd'

require('lazy').setup({
  require("plugins.themes.gruvbox-material"),
  require("plugins.neo-tree"),
  require("plugins.fzf"),
  require("plugins.gitsigns"),
  require("plugins.blink-cmp"),
  require("plugins.lsp"),
  require("plugins.neoscroll"),
  require("plugins.lualine"),
  require("plugins.tree-sitter"),
  require("plugins.nvim-autopairs"),
  require("plugins.which-key"),
})

