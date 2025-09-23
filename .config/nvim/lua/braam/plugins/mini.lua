vim.pack.add {
  { src = "https://github.com/echasnovski/mini.nvim" },
}

require "mini.pick".setup()
vim.keymap.set('n', '<leader>pf', "<Cmd>Pick files<CR>")
vim.keymap.set('n', '<leader>pr', "<Cmd>Pick buffers<CR>")
vim.keymap.set('n', '<leader>ph', "<Cmd>Pick help<CR>")

