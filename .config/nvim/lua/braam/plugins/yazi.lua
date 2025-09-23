vim.pack.add {
  { src = "https://github.com/mikavilpas/yazi.nvim" },
}

local yazi = require "yazi"
yazi.setup {
  open_for_directories = false,
}
vim.g.loaded_netrwPlugin = 1

vim.keymap.set('n', "<leader>-", function() yazi.yazi() end)

