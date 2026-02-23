-- lua/plugins/lualine.lua
local get_python_path = require('core.helpers').get_python_path

-- текущее отображаемое venv
local current_venv = ""

-- функция для lualine, возвращает имя venv
local function venv_component()
  return current_venv
end

-- обновление venv
local function update_venv()
  local workspace = vim.fn.getcwd()
  local python_path = get_python_path(workspace)

  if python_path and python_path ~= "python3" then
    current_venv = "🌍 " .. vim.fn.fnamemodify(vim.fn.fnamemodify(python_path, ":h:h"), ":t")
  else
    current_venv = ""
  end

  -- обновляем lualine
  vim.defer_fn(function()
    require('lualine').refresh({ place = { 'c' } })
  end, 10)
end

-- автокоманды для обновления при смене директории
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  callback = update_venv
})

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'gruvbox-material',
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', venv_component }, -- Add the venv component here
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    },
  },
}
