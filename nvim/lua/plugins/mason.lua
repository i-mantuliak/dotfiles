return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      PATH = "prepend",
    },
  },
}
