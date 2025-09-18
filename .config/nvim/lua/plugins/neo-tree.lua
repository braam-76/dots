return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>-", ":Neotree<CR>", { desc = "Open explorer (neo-tree)" })
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style   = "NC",
        enable_git_status    = true,
        enable_diagnostics   = true,
        window = {
          position = "left",
          width    = 30,
          mappings = {
            ["<leader>"] = { "toggle_node" },
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      })
    end,
  },
}
