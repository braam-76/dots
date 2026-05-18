vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/Olical/conjure" },

  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/saghen/blink.cmp" },

  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

local cmp = require("blink.cmp")
cmp.build():wait(60000)

cmp.setup({
  keymap = { preset = "default" },

  appearance = { nerd_font_variant = "mono" },

  completion = {
    documentation = { auto_show = false },
  },

  signature = { enabled = true },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})

require("luasnip.loaders.from_vscode").lazy_load()

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
  "jdtls",
  "racket_langserver",
})

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
  desc = "Format buffer",
})
