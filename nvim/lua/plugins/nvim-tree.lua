return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { '\\', ':NvimTreeToggle<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}
