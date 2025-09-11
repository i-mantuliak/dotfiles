require 'core.options' -- Load general options
require 'core.lazy' -- Load Lazy plugin manager
require 'core.keymaps' -- Load general keymaps
-- require 'core.snippets' -- Custom code snippets
-- require 'tools.sql-runner'

-- Install package manager


require('lazy').setup({
  require("plugins.themes.gruvbox"),
  require("plugins.neo-tree"),
})
