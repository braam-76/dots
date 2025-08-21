return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "clangd",
        "gopls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",        -- For installing LSP servers
      "williamboman/mason-lspconfig.nvim", -- For configuring LSP servers
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            format = {
              enable = true,
              -- Put format options here
              -- NOTE: the value should be String!
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
            workspace = {
              library = { vim.env.VIMRUNTIME },
              checkThirdParty = false,
            },
          },
        },
      })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({ capabilities = capabilities })
      lspconfig.gopls.setup({ capabilities = capabilities })
      vim.keymap.set(
        "n",
        "<leader>lh",
        vim.lsp.buf.hover,
        { desc = "[l]sp: get info on [h]over (nvim-lspconfig)" }
      )
      vim.keymap.set(
        "n",
        "<leader>ld",
        vim.lsp.buf.definition,
        { desc = "[l]sp: goto [d]efinition (nvim-lspconfig)" }
      )
      vim.keymap.set(
        "n",
        "<leader>la",
        vim.lsp.buf.code_action,
        { desc = "[l]sp: code [a]ction (nvim-lspconfig)" }
      )
    end,
  },
}
