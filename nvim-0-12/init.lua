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
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate", },

  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim', },
  { src = 'https://github.com/mason-org/mason.nvim', },
  { src = 'https://github.com/saghen/blink.cmp',                version = "v1", },

  { src = 'https://github.com/folke/which-key.nvim', },

  { src = 'https://github.com/ibhagwan/fzf-lua', },

  { src = "https://github.com/sainnhe/gruvbox-material" },
  { src = 'https://github.com/akinsho/bufferline.nvim', },
  { src = 'https://github.com/nvim-lualine/lualine.nvim', },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/karb94/neoscroll.nvim' },

  { src = 'https://github.com/lewis6991/gitsigns.nvim', },

  { src = 'https://github.com/nvim-mini/mini.surround', },
  { src = 'https://github.com/nvim-mini/mini.move', },
  { src = 'https://github.com/nvim-mini/mini.pairs', },
  { src = 'https://github.com/nvim-mini/mini.files', },
  { src = 'https://github.com/nvim-mini/mini.indentscope', },
})

require('mini.surround').setup()
require('mini.move').setup()
require('mini.pairs').setup()
require('mini.indentscope').setup()
require('mini.files').setup({
  mappings = {
    close      = '<ESC>',
    go_in_plus = '<CR>',
  },
})
require("neoscroll").setup({ duration_multiplier = 0.4 })

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
-------------- styling ----------------
---------------------------------------
require('bufferline').setup()
require('lualine').setup()

---------------------------------------
------------ fuzzy finder -------------
---------------------------------------
require('fzf-lua').setup {
  keymap = {
    -- fzf = {
    --     ["ctrl-u"] = "preview-page-up",
    --     ["ctrl-d"] = "preview-page-down",
    -- },
    builtin = {
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    }
  }
}

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
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

---------------------------------------
------------- LSP config --------------
---------------------------------------
vim.lsp.on_type_formatting.enable()
local servers = {
  "pyright",
  "ruff",
  "taplo",
  "lua_ls",
  "bashls",
  "helm_ls",
  "kotlin_language_server",
}
require("mason").setup()
require('mason-lspconfig').setup {
  ensure_installed = servers,
  automatic_installation = true,
  automatic_enable = true,
}
require('blink.cmp').setup({
  signature = { enabled = true },
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = {
    documentation = { auto_show = true },
    accept = { auto_brackets = { enabled = false }, },
  },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
  fuzzy = { implementation = "lua" }
})
local capabilities = require('blink.cmp').get_lsp_capabilities()
local on_attach_lsp = function(client, bufnr)
  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end
  map('n', 'grn', vim.lsp.buf.rename, '[R]e[n]ame')
  map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction')
  map('n', 'grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'grd', vim.lsp.buf.definition, '[G]oto [D]definition')
  map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]definition')
  map('n', '<leader>df', vim.diagnostic.open_float, 'Show [d]iagnostics [f]loat')
  map('n', '<leader>dl', vim.diagnostic.setloclist, 'Show [d]iagnostics [l]ist')
  map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  map('n', 'K', vim.lsp.buf.hover, "Show documentation for what is under cursor")
end
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
    on_attach = on_attach_lsp,
  })
  vim.lsp.enable(server)
end
-- Set indentation to 2 spaces
vim.api.nvim_create_autocmd('Filetype', {
  pattern = { 'css', 'html', 'javascript',
    'lua', 'markdown', 'md', 'typescript',
    'scss', 'xml', 'xhtml', 'yaml', 'sh', 'bash',
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})


-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Return cursor to last known position
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  desc = 'return cursor to where it was last time closing the file',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})

---------------------------------------
-------------- gitsigns ---------------
---------------------------------------
require('gitsigns').setup {
  signs      = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  signcolumn = false,   -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true,    -- Toggle with `:Gitsigns toggle_numhl`
  on_attach  = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, desc, opts)
      opts = opts or {}
      opts.buffer = bufnr
      opts.desc = desc
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, 'Next hunk')

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, 'Prev hunk')

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
    map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Stage selected hunk')

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Reset selected hunk')

    map('n', '<leader>hS', gitsigns.stage_buffer, 'Stage buffer')
    map('n', '<leader>hR', gitsigns.reset_buffer, 'Reset buffer')
    map('n', '<leader>hp', gitsigns.preview_hunk, 'Preview hunk')
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, 'Preview hunk inline')

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, 'Blame line')

    map('n', '<leader>hd', gitsigns.diffthis, 'Diff against index')

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end, 'Diff against last commit')

    map('n', '<leader>hQ', function()
      gitsigns.setqflist('all')
    end, 'Send all hunks to quickfix')

    map('n', '<leader>hq', gitsigns.setqflist, 'Send hunks to quickfix')

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle line blame')
    map('n', '<leader>tw', gitsigns.toggle_word_diff, 'Toggle word diff')

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
  end
}

-- Map opts arguments
local default_opts = { noremap = true, silent = true }
local function map(mode, lhs, rhs, desc)
  local opts = vim.tbl_extend("force", default_opts, { desc = desc })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Delete single character without copying into register
map('n', 'x', '"_x', "Delete single character without copying into register")
-- Open MiniFiles
map({ 'n', 'v' }, '\\', function() MiniFiles.open() end, "Open MiniFiles")
-- FzfLua
map('n', '<leader>sf', ':FzfLua files<CR>', "Search files")
map('n', '<leader>sg', ':FzfLua live_grep<CR>', "Search in project")
map('n', '<leader>sb', ':FzfLua buffers<CR>', "Search buffers")
map('n', '<leader>sh', ':FzfLua help_tags<CR>', "Search help")
map('n', '<leader>sk', ':FzfLua keymaps<CR>', "Search hotkeys")
map('n', '<leader>sr', ':FzfLua resume<CR>', "Back to last search")
map('n', '<leader>lr', ':FzfLua lsp_references<CR>', "Search references")
map('n', '<leader>ld', ':FzfLua lsp_definitions<CR>', "Search references")
map('n', '<leader>lD', ':FzfLua diagnostics_document<CR>', "Search references")
map('n', '<leader>ss', ':FzfLua blines<CR>', "Search in file")

-- Buffers
map('n', '<Tab>', ':bnext<CR>', "Next buffer")
map('n', '<S-Tab>', ':bprevious<CR>', "Previous buffer")
map('n', '<leader>bx', ':bdelete!<CR>', "Close buffer")
map('n', '<leader>bn', '<cmd> enew <CR>', "New buffer")
map('n', '<leader>bl', '<cmd> ls <CR>', "List buffers")
-- Navigate between splits
map('n', '<C-k>', ':wincmd k<CR>', "Move to UP window")
map('n', '<C-j>', ':wincmd j<CR>', "Move to DOWN window")
map('n', '<C-h>', ':wincmd h<CR>', "Move to LEFT window")
map('n', '<C-l>', ':wincmd l<CR>', "Move to RIGHT window")
-- Leave cursor in the middle of the page
map('n', '<C-d>', '<C-d>zz', "Leave cursor in the middle of the page")
map('n', '<C-b>', '<C-b>zz', "Leave cursor in the middle of the page")
map('n', '<C-u>', '<C-u>zz', "Leave cursor in the middle of the page")
map('n', '<C-f>', '<C-f>zz', "Leave cursor in the middle of the page")
-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>', "Clear highlights by pressing ESC in normal mode")
