vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.keymap.set("n", "<leader>g", "<cmd>Neogit<CR>")
