-- format with 2 spaces in lua files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
  end,
})

-- Find helm root directory
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = {"*.yaml", "*.yml", "*.tpl"},
  callback = function()
    local chart_root = vim.fn.findfile("Chart.yaml", ".;")
    if chart_root ~= "" then
      vim.bo.filetype = "helm"
    end
  end
})

-- Find helm root directory
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = {"*.yaml", "*.yml", "*.tpl"},
  callback = function()
    local chart_root = vim.fn.findfile("Chart.yaml", ".;")
    if chart_root ~= "" then
      vim.bo.filetype = "helm"
    end
  end
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
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
