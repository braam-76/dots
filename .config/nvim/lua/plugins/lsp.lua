return {
  {
    "neovim/nvim-lspconfig",

    config = function()
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".git" },

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "require" },
            },

            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      })

      vim.lsp.enable({
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
