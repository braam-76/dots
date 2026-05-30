local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<C-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
