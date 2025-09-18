-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local default_opts = { noremap = true, silent = true }

-- Map opts arguments
local function map(mode, lhs, rhs, desc)
  local opts = vim.tbl_extend("force", default_opts, { desc = desc })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', default_opts)

-- ====== FzfLua ======
map('n', '<leader>sf', ':FzfLua files<CR>',      "Search files")
map('n', '<leader>sg', ':FzfLua live_grep<CR>',  "Search in project")
map('n', '<leader>sb', ':FzfLua buffers<CR>',    "Search buffers")
map('n', '<leader>sh', ':FzfLua help_tags<CR>',  "Search help")
map('n', '<leader>sk', ':FzfLua keymaps<CR>',    "Search hotkeys")
map('n', '<leader>sr', ':FzfLua resume<CR>',     "Back to last search")
map('n', '<leader>ss', ':FzfLua blines<CR>',     "Search in file")

-- Buffers
map('n', '<Tab>',      ':bnext<CR>',             "Next buffer")
map('n', '<S-Tab>',    ':bprevous<CR>',          "Previous buffer")
map('n', '<leader>bx', ':bdelete!<CR>',          "Close buffer")
map('n', '<leader>bn', '<cmd> enew <CR>',        "New buffer")
map('n', '<leader>bl', '<cmd> ls <CR>',          "List buffers")

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', default_opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', default_opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', default_opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', default_opts)

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', default_opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', default_opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', default_opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', default_opts)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


vim.keymap.set('n', '<C-d>', '<C-d>zz', default_opts)
vim.keymap.set('n', '<C-b>', '<C-b>zz', default_opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', default_opts)
vim.keymap.set('n', '<C-f>', '<C-f>zz', default_opts)
