local M = {}

-- Help to get .venv path
local function get_python_path(workspace)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  end
  for _, venv in ipairs({ '.venv', 'venv' }) do
    local path = workspace .. '/' .. venv .. '/bin/python'
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
  return 'python3'
end

M.get_python_path = get_python_path

return M
