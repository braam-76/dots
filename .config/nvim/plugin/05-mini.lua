vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.icons" },
})

require("mini.icons").setup()
require("mini.pairs").setup()

local mini_pick = require("mini.pick")
mini_pick.setup()

local pick = mini_pick.builtin

vim.keymap.set("n", "<leader>f", function()
  pick.files()
end, { desc = "Mini files" })
vim.keymap.set("n", "<leader>mg", function()
  pick.grep_live()
end, { desc = "Mini grep live" })
vim.keymap.set("n", "<leader>mb", function()
  pick.buffers()
end, { desc = "Mini buffers" })
vim.keymap.set("n", "<leader>mh", function()
  pick.help()
end, { desc = "Mini help" })
