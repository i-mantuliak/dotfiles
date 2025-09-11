-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>e', ':Neotree <CR>', { desc = 'Open Neo-tree explorer' })

vim.keymap.set('n', '<leader>sf', ':FzfLua files <CR>', { desc = 'Fuzzy search files'})
vim.keymap.set('n', '<leader>sg', ':FzfLua <CR>', { desc = 'Fuzzy grep'})

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>bx', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>bn', '<cmd> enew <CR>', opts) -- new buffer
vim.keymap.set('n', '<leader>bl', '<cmd> ls <CR>', opts) -- new buffer
