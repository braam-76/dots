return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      default_file_explorer = true,
      columns = { "icon" },
      view_options = { show_hidden = true },
    },

    keys = {
      { "<leader>o", "<cmd>Oil<CR>", desc = "Open Oil" },
    },
  },
}
