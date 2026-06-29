-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.wo.number = true            -- Make line numbers default (default: false)
vim.o.relativenumber = true     -- Set relative numbered lines (default: false)
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim. (default: '')
vim.o.wrap = true               -- Display lines as one long line (default: true)
vim.o.linebreak = true          -- Companion to wrap, don't split words (default: false)
vim.o.mouse = 'a'               -- Enable mouse mode (default: '')
vim.o.autoindent = true         -- Copy indent from current line when starting new one (default: true)
vim.o.ignorecase = true         -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.o.smartcase = true          -- Smart case (default: false)
vim.o.shiftwidth = 4            -- The number of spaces inserted for each indentation (default: 8)
vim.o.tabstop = 4               -- Insert n spaces for a tab (default: 8)
vim.o.softtabstop = 4           -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.o.expandtab = true          -- Convert tabs to spaces (default: false)
vim.o.scrolloff = 8             -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.o.sidescrolloff = 8         -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.o.cursorline = true         -- Highlight the current line (default: false)
vim.o.splitbelow = true         -- Force all horizontal splits to go below current window (default: false)
vim.o.splitright = true         -- Force all vertical splits to go to the right of current window (default: false)
vim.o.hlsearch = false          -- Set highlight on search (default: true)
vim.o.showmode = false          -- We don't need to see things like -- INSERT -- anymore (default: true)
vim.o.signcolumn = 'yes'        -- Always show signcolumn
vim.o.updatetime = 250          -- Decrease update time
vim.o.list = true               -- Sets how neovim will display certain whitespace characters in the editor
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.o.winborder = "rounded"
vim.o.termguicolors = true


vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "https://github.com/sainnhe/gruvbox-material",
})

---------------------------------------
----------- gruvbox-material ----------
---------------------------------------
vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_disable_italic_comment = false
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_enable_bold = true
vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("slate")

---------------------------------------
----------- nvim-treesitter -----------
---------------------------------------
local parsers = {
  "lua", "vim", "vimdoc", "query", "dockerfile", "zsh", "nginx",
  "python", "html", "xml", "java", "helm", "jinja", "toml",
  "json", "yaml", "markdown", "bash", "go", "kotlin",
}
require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
}
require('nvim-treesitter').install(parsers)
vim.api.nvim_create_autocmd('FileType', {
  pattern = parsers,
  callback = function() vim.treesitter.start() end,
})






-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Return cursor to last known position
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
  desc = 'return cursor to where it was last time closing the file',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})

