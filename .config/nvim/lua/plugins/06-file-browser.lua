return {
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
        columns = { "permissions", "size", "mtime", "icon" },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      view = { width = 30 },
      renderer = { group_empty = true },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        mode = { "n" },
        desc = "Open file tree",
      },
    },
  },
}
