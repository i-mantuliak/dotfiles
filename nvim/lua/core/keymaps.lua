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

-- Delete single character without copying into register
map('n', 'x', '"_x', "Delete single character without copying into register")

-- FzfLua
map('n', '<leader>sf', ':FzfLua files<CR>',      "Search files")
map('n', '<leader>sg', ':FzfLua live_grep<CR>',  "Search in project")
map('n', '<leader>sb', ':FzfLua buffers<CR>',    "Search buffers")
map('n', '<leader>sh', ':FzfLua help_tags<CR>',  "Search help")
map('n', '<leader>sk', ':FzfLua keymaps<CR>',    "Search hotkeys")
map('n', '<leader>sr', ':FzfLua resume<CR>',     "Back to last search")
map('n', '<leader>ss', ':FzfLua blines<CR>',     "Search in file")

-- Buffers
map('n', '<Tab>',      ':bnext<CR>',             "Next buffer")
map('n', '<S-Tab>',    ':bprevious<CR>',          "Previous buffer")
map('n', '<leader>bx', ':bdelete!<CR>',          "Close buffer")
map('n', '<leader>bn', '<cmd> enew <CR>',        "New buffer")
map('n', '<leader>bl', '<cmd> ls <CR>',          "List buffers")

-- Resize with arrows
map('n', '<Up>', ':resize -2<CR>', "Resize with arrows")
map('n', '<Down>', ':resize +2<CR>', "Resize with arrows")
map('n', '<Left>', ':vertical resize -2<CR>', "Resize with arrows")
map('n', '<Right>', ':vertical resize +2<CR>', "Resize with arrows")

-- Navigate between splits
map('n', '<C-k>', ':wincmd k<CR>', "Move to UP window")
map('n', '<C-j>', ':wincmd j<CR>', "Move to DOWN window")
map('n', '<C-h>', ':wincmd h<CR>', "Move to LEFT window")
map('n', '<C-l>', ':wincmd l<CR>', "Move to RIGHT window")

-- Leave cursor in the middle of the page
map('n', '<C-d>', '<C-d>zz', "Leave cursor in the middle of the page" )
map('n', '<C-b>', '<C-b>zz', "Leave cursor in the middle of the page" )
map('n', '<C-u>', '<C-u>zz', "Leave cursor in the middle of the page" )
map('n', '<C-f>', '<C-f>zz', "Leave cursor in the middle of the page" )

-- New line on Shift+Enter even if not in the end of line
map("i", "<S-CR>", "<Esc>o", "New line on Shift+Enter even if not in the end of line")
map("i", "<C-S-CR>", "<Esc>O", "New line on Ctrl+Shift+Enter even if not in the end of line")

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>', "Clear highlights by pressing ESC in normal mode")

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
map("n", "<A-k>", ":m .-2<CR>==", "Move line up")
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- Better indenting in visual mode
map("v", "<", "<gv", "Indent left and reselect")
map("v", ">", ">gv", "Indent right and reselect")
