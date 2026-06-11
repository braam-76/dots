-- Options --
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.o.clipboard = "unnamedplus"

vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.inccommand = "split"
vim.o.confirm = true

vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  virtual_text = true,
  virtual_lines = false,

  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = "cursor",
        focus = false,
      })
    end,
  },
})

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<C-w>", { desc = "Better C-w" })
map("n", "<leader>-", "<cmd>Explore<CR>", { desc = "Open netrw" })

-- Themes --
vim.pack.add({ "https://github.com/vague2k/vague.nvim" })
vim.cmd.colorscheme("vague")

-- Flash --
vim.pack.add({ "https://github.com/folke/flash.nvim" })

local f = require("flash")
map({ "n", "x", "o" }, "<leader>s", f.jump, { desc = "Flash" })
map({ "n", "x", "o" }, "<leader>S", f.treesitter, { desc = "Flash Treesitter" })
map({ "o" }, "r", f.remote, { desc = "Remote Flash" })
map({ "o", "x" }, "R", f.treesitter_search, { desc = "Treesitter Search" })
map({ "c" }, "<c-s>", f.toggle, { desc = "Toggle Flash Search" })

-- Which key --
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
local wk = require("which-key")
map("n", "<leader>?", wk.show, { desc = "Buffer Local Keymaps (which-key)" })

-- Typst --
vim.pack.add({ "https://github.com/chomosuke/typst-preview.nvim" })

require("typst-preview").setup({
  dependencies_bin = {
    ["tinymist"] = "tinymist",
    ["websocat"] = "websocat",
  },
})

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

-- Markdown --
vim.pack.add({ "https://github.com/iamcco/markdown-preview.nvim" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>pr", "<cmd>MarkdownPreview<CR>", {
      desc = "Markdown Preview",
    })
  end,
})

-- LSP --
vim.pack.add({
  "https://github.com/saghen/blink.cmp",
  "https://github.com/saghen/blink.lib",

  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",

  "https://github.com/neovim/nvim-lspconfig",

  "https://github.com/stevearc/conform.nvim",
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
  appearance = { nerd_font_variant = "mono" },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
  },

  sources = { default = { "lsp", "path", "snippets" } },
  snippets = { preset = "luasnip" },
  fuzzy = { implementation = "lua" },
  signature = { enabled = true },
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

map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })

-- Formatting --
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = true,
})

vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/braam-76/mini-in-one.nvim",
})

-- Mini --
---@type MiniInOne
local mini_in_one = require("mini-in-one")
mini_in_one.setup({
  icons = "defaults",
  pairs = "defaults",
  surround = "defaults",
  diff = "defaults",
  notify = "defaults",
  indentscope = "defaults",

  ai = {
    mappings = {
      around_next = "aa",
      inside_next = "ii",
    },
    n_lines = 500,
  },

  statusline = {
    use_icons = vim.g.have_nerd_font,
  },

  pick = {
    window = {
      config = { border = "rounded" },
    },
  },
})

local pick = mini_in_one.pick.builtin
map("n", "<leader> ", pick.files, { desc = "Mini files" })
map("n", "<leader>mg", pick.grep_live, { desc = "Mini grep live" })
map("n", "<leader>mb", pick.buffers, { desc = "Mini buffers" })
map("n", "<leader>mh", pick.help, { desc = "Mini help" })

-- Git --
vim.pack.add({ "https://github.com/NeogitOrg/neogit" })

map("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
