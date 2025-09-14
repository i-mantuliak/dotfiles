require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.lazy' -- Load Lazy plugin manager
-- require 'core.lsp'

-- Install package manager and packages
require('lazy').setup({
  require("plugins.themes.gruvbox-material"),
  require("plugins.neo-tree"),
  require("plugins.fzf"),
})
