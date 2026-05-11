return {
  {
    "neovim/nvim-lspconfig",

    config = function()
      vim.lsp.config("tinymist", {
        cmd = { "tinymist" },
        filetypes = { "typst" },
        root_markers = { ".git" },
        on_attach = function(client, bufnr)
          vim.keymap.set(
            "n",
            "<leader>pr",
            "<cmd>TypstPreview<CR>",
            {
              buffer = bufnr,
              desc = "Typst Preview",
            }
          )
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

      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
        desc = "Format buffer",
      })
    end,
  },
}
