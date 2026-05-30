return {
  "NeogitOrg/neogit",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>g", "<cmd>Neogit<CR>", desc = "Open Neogit" },
  },
  cmd = "Neogit", -- Also load when :Neogit command is called
}
