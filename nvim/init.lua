require 'core.options' -- Load general options
-- require 'core.keymaps' -- Load general keymaps
-- require 'core.snippets' -- Custom code snippets
-- require 'tools.sql-runner'

-- Install package manager
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

local default_color_scheme = 'gruvbox'
local themes = {
  nord = 'plugins.themes.nord',
  gruvbox = 'plugins.themes.gruvbox',
}

require('lazy').setup({
  require(themes[default_color_scheme]),
  require("plugins.neo-tree"),
})
