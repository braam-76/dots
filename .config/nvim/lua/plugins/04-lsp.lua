return {
  -- LSP
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saghen/blink.lib",
    },
    opts = {
      keymap = { preset = "super-tab" },
      appearance = { nerd_font_variant = "mono" },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },

      sources = { default = { "lsp", "path", "snippets" } },
      snippets = { preset = "luasnip" },
      fuzzy = { implementation = "lua" },
      signature = { enabled = true },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- LSP configuration
      vim.lsp.config("tinymist", {
        cmd = { "tinymist" },
        filetypes = { "typst" },
        settings = {
          formatterMode = "typstyle",
          exportPdf = "onType",
          semanticTokens = "enable",
        },
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>pr", "<cmd>TypstPreview<CR>", {
            buffer = bufnr,
            desc = "Typst Preview",
          })
        end,
      })

      vim.lsp.enable({
        "tinymist",
        "lua_ls",
        "basedpyright",
        "rust_analyzer",
        "clangd",
        "cmake",
        "jdtls",
        "racket_langserver",
      })

      -- Global format keymap
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
        desc = "Format buffer",
      })
    end,
  },

  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt", lsp_format = "fallback" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = true,
      })
    end,
  },

  -- Conjure for REPL support
  {
    "Olical/conjure",
    init = function()
      vim.g["conjure#log#hud#enabled"] = false
    end,
  },
}
