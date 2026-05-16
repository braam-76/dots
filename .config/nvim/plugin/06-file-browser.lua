vim.pack.add({
  {
    src = "https://github.com/mikavilpas/yazi.nvim",
    version = vim.version.range("*"),
  },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
})

vim.keymap.set({ "n", "v" }, "<leader>y", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })

require("oil").setup({
  default_file_explorer = true,
  columns = { "permission", "size", "mtime", "icon" },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
