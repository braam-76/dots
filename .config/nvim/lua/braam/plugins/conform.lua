vim.pack.add {
  { src = "https://github.com/stevearc/conform.nvim" },
}

local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    python = { "ruff_organize_imports", "ruff_format" },
    lua = { "stylua" },
    cpp = { "clang_format" },
  },
}

vim.keymap.set("n", "<leader>lf", function() conform.format() end)
