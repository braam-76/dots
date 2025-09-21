vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.winborder = 'rounded'

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.inccommand = 'split'
vim.o.confirm = true
local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


vim.pack.add {
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },

  { src = "https://github.com/folke/flash.nvim" },

  { src = "https://github.com/thesimonho/kanagawa-paper.nvim" }
}

vim.cmd.colorscheme "kanagawa-paper"

map('n', '<leader>g', '<cmd>Neogit<CR>')

map('n', '<leader>pf', "<Cmd>Pick files<CR>")
map('n', '<leader>pr', "<Cmd>Pick buffers<CR>")
map('n', '<leader>ph', "<Cmd>Pick help<CR>")

map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>')

map("n", "<leader>so", ":update<CR> :source<CR>")

map({ "n", "x", "o" }, "s", function() require("flash").jump() end)
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end)
map("o", "r", function() require("flash").remote() end)
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end)

require "mini.pick".setup()
require "blink.cmp".setup({
  signature = { enabled = true },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = {
      auto_show = true,
      draw = {
        treesitter = { "lsp" },
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
      },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "require" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "zls",
  "gopls"
})
