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

vim.env.PATH = vim.env.PATH .. ":/home/linuxbrew/.linuxbrew/bin"

-- require "innoitta_nvim.lua.innoitta".setup()

require "braam/plugins"
