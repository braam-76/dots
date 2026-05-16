vim.pack.add({
  { src = "https://github.com/folke/flash.nvim" },
})

local flash = require("flash")

vim.keymap.set({ "n", "x", "o" }, "s", flash.jump)
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter)
vim.keymap.set("o", "r", flash.remote)
vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search)
