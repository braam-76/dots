vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'

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

vim.keymap.set('n', '<Esc>',     '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-Left>',  '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Down>',  '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Up>',    '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

local opts = {}

require("lazy").setup("plugins")
