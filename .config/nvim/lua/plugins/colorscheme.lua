return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin-macchiato")
  end
}

-- return {
--   "ntk148v/vim-horizon",
--   config = function()
--     vim.cmd.colorscheme("horizon")
--   end
-- }
