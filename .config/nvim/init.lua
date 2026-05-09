vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

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

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>")


-- Theme
vim.pack.add {
  {src = "https://github.com/phha/zenburn.nvim"},
    { src = "https://github.com/vague2k/vague.nvim" },
}

vim.cmd[[colorscheme vague]]

-- Flash.nvim
vim.pack.add {
  { src = "https://github.com/folke/flash.nvim" },
}

vim.keymap.set({ "n", "x", "o" }, "s", function() require "flash".jump() end)
vim.keymap.set({ "n", "x", "o" }, "S", function() require "flash".treesitter() end)
vim.keymap.set({ "o" },           "r", function() require "flash".remote() end)
vim.keymap.set({ "o", "x" },      "R", function() require "flash".treesitter_search() end)

-- File manager
vim.pack.add {
  { src = "https://github.com/stevearc/oil.nvim" },
}

require "oil".setup {
  default_file_explorer = true,
  columns = { "icon" },
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")

-- Git UI
vim.pack.add {
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
}

vim.keymap.set("n", "<leader>g", "<cmd>Neogit<CR>")

-- LSP
vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.enable {
  "lua_ls",
  "pyright",
  "rust_analyzer",

  "clangd",
  "cmake", -- NOTE: remember to install 'cmake-language-server' with pip on new system
}

