require 'core.keymaps'
require 'core.options'
require 'core.lazy'
require 'core.autocmd'

require('lazy').setup({
  require("plugins.themes.gruvbox-material"),
  require("plugins.blink-cmp"),
  require("plugins.bufferline"),
  require("plugins.fzf"),
  require("plugins.gitsigns"),
  require("plugins.lazygit"),
  require("plugins.lsp"),
  require("plugins.lualine"),
  require("plugins.neo-tree"),
  require("plugins.neoscroll"),
  require("plugins.nvim-autopairs"),
  require("plugins.toggleterm"),
  require("plugins.tree-sitter"),
  require("plugins.which-key"),
})

