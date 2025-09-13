require 'core.options' -- Load general options
require 'core.lazy' -- Load Lazy plugin manager
require 'core.keymaps' -- Load general keymaps
require 'core.lsp'

-- Install package manager
require('lazy').setup({
  require("plugins.themes.gruvbox-material"),
  require("plugins.neo-tree"),
  require("plugins.fzf"),
  -- require("plugins.treesitter"),
})
