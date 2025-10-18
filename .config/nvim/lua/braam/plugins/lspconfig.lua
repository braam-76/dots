vim.pack.add {
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/DrKJeff16/wezterm-types" },

  { src = "https://github.com/onsails/lspkind.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
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

local supported_categories = {
  "file",
  "folder",
  "diagnostic",
  "function",
  "variable",
  "class",
  "module",
  "method",
  "property",
  "enum",
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
  keymap = {
    ["C-k"] = { "show_signature", "hide_signature", "fallback" },
  },
  completion = {
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then icon = dev_icon end
              else
                icon = require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end

              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then hl = dev_hl end
              end
              return hl
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
  "ts_ls",

  "clangd",
  "cmake", -- NOTE: remember to install 'cmake-language-server' with pip on new system
}
