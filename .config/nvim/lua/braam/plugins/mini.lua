vim.pack.add {
  { src = "https://github.com/echasnovski/mini.nvim" },
}

require("mini.icons").setup()

require("mini.pick").setup {
  options = {
    windows = {
      picker = {
        find_command = { "fd", "--type", "f", "--hidden", "--follow" },
      },
    },
  },
}
vim.keymap.set("n", "<leader>-", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>pr", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<leader>ph", "<Cmd>Pick help<CR>")
