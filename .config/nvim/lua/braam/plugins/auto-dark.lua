vim.pack.add {
  "https://github.com/f-person/auto-dark-mode.nvim",
}

require("auto-dark-mode").setup {
  set_dark_mode = function() vim.cmd.colorscheme "vague" end,

  set_light_mode = function() vim.cmd.colorscheme "paper" end,

  update_interval = 1000,
}
