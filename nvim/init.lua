require 'core.options'
require 'core.keymaps'
require 'core.lazy'

require('lazy').setup({
  require("plugins.themes.gruvbox-material"),
  require("plugins.neo-tree"),
  require("plugins.fzf"),
  require("plugins.gitsigns"),
  require("plugins.nvim-cmp"),
  require("plugins.lsp"),
  require("plugins.neoscroll"),
  require("plugins.lualine"),
})

