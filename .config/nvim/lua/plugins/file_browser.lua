return {
  "mikavilpas/yazi.nvim",
  version = "*",   -- use the latest stable version
  lazy = false,
  priority = 999,
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    { "<leader>-", "<cmd>Yazi<cr>", desc = "Open yazi at the current file", mode = { "n", "v" }, },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
