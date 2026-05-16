vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.completion" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.icons" },
})

require("mini.icons").setup()
require("mini.completion").setup()
require("mini.pairs").setup()

local mini_pick = require("mini.pick")
mini_pick.setup()

local pick = mini_pick.builtin

vim.keymap.set("n", "<leader>f", pick.files, { desc = "Mini files" })
vim.keymap.set("n", "<leader>mg", pick.grep_live, { desc = "Mini grep live" })
vim.keymap.set("n", "<leader>mb", pick.buffers, { desc = "Mini buffers" })
vim.keymap.set("n", "<leader>mh", pick.help, { desc = "Mini help" })
