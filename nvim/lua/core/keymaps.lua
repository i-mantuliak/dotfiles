-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>e', ':Neotree <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Fzf keymaps
vim.keymap.set('n', '<leader>sf', ':FzfLua files <CR>', opts)
vim.keymap.set('n', '<leader>sg', ':FzfLua lgrep_curbuf<CR>', opts)
vim.keymap.set('n', '<leader>ss', ':FzfLua live_grep<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>bx', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>bn', '<cmd> enew <CR>', opts) -- new buffer
vim.keymap.set('n', '<leader>bl', '<cmd> ls <CR>', opts) -- new buffer

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

