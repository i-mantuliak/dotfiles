local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

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
