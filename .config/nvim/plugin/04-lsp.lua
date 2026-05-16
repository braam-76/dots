vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = true,
})

vim.lsp.config("tinymist", {
  cmd = { "tinymist" },
  filetypes = { "typst" },

  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "enable",
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<leader>pr", "<cmd>TypstPreview<CR>", {
      buffer = bufnr,
      desc = "Typst Preview",
    })
  end,
})

vim.lsp.enable({
  "tinymist",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "clangd",
  "cmake",
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })
