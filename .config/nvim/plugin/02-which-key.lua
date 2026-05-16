vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
})

local wk = require("which-key")

vim.keymap.set({ "n", "x", "v" }, "<leader>?", function()
  wk.show({ global = false })
end, { desc = "Buffer local Keymaps (which-key)" })
