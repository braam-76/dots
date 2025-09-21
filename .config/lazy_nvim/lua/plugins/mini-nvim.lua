return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function ()
    require "mini.icons".setup()
    require "mini.pick".setup()
    vim.keymap.set("n", "<leader>pf", "<Cmd>Pick files<CR>", { desc = "mini.[p]ick [f]iles" })
    vim.keymap.set("n", "<leader>pb", "<Cmd>Pick buffers<CR>", { desc = "mini.[p]ick [b]uffers" })
  end
}
