vim.pack.add {
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/miikanissi/modus-themes.nvim" },
  { src = "https://github.com/yorickpeterse/vim-paper" },

  { src = "https://github.com/f-person/auto-dark-mode.nvim" },

  { src = "https://github.com/zenbones-theme/zenbones.nvim" },
  { src = "https://github.com/jaredgorski/Mies.vim" },
  { src = "https://github.com/rktjmp/lush.nvim" },
}

require("auto-dark-mode").setup {
  set_dark_mode = function()
    vim.o.background = "dark"
    vim.cmd.colorscheme "vague"
  end,
  set_light_mode = function()
    vim.o.background = "light"
    vim.cmd.colorscheme "mies"
  end,
  update_interval = 1000,
}
-- vim.cmd.set "notermguicolors"
--
