return {
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>y", "<cmd>Yazi<cr>", mode = { "n", "v" }, desc = "Open yazi at the current file" },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = { "permission", "size", "mtime", "icon" },
      })
    end,
  },
}
