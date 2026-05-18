vim.pack.add({
  { src = "https://github.com/chomosuke/typst-preview.nvim", version = vim.version.range("*") },
})

require("typst-preview").setup({
  dependencies_bin = {
    ["tinymist"] = "tinymist",
    ["websocat"] = "websocat",
  },
})
