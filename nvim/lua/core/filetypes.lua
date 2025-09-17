-- Helm filetypes
vim.filetype.add {
  extension = {
    tpl = "helm",
  },
  filename = {
    ["values.yaml"] = "helm",
    ["values.yml"] = "helm",
  },
  pattern = {
    -- всё, что в папке templates/ у чарта
    [".*/templates/.*%.yaml"] = "helm",
    [".*/templates/.*%.yml"] = "helm",
  },
}

