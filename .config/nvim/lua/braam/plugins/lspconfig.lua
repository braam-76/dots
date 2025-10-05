vim.pack.add {
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/DrKJeff16/wezterm-types" },

  {src = "https://github.com/onsails/lspkind.nvim"}
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
})

vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
}

require("lazydev").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "wezterm-types", mods = { "wezterm" } },
  },
}

require("blink.cmp").setup {
  fuzzy = {
    implementation = "prefer_rust",
  },
  signature = { enabled = true },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    menu = {
      auto_show = true,
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local mini_icon, _ = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                if mini_icon then return mini_icon .. ctx.icon_gap end
              end

              local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from mini.icons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                if mini_icon then return mini_hl end
              end
              return ctx.kind_hl
            end,
          },
          kind = {
            -- Optional, use highlights from mini.icons
            highlight = function(ctx)
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                if mini_icon then return mini_hl end
              end
              return ctx.kind_hl
            end,
          },
        },
      },
    },
  },
}

vim.lsp.enable {
  "lua_ls",
  "gopls",
  "jdtls",
  "pyright",
  "rust_analyzer",

  "clangd",
  "cmake", -- NOTE: remember to install 'cmake-language-server' with pip on new system
}
