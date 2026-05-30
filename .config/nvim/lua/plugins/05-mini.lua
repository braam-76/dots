return {
  "nvim-mini/mini.nvim",

  config = function()
    require("mini.icons").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.ai").setup({
      mappings = {
        around_next = "aa",
        inside_next = "ii",
      },
      n_lines = 500,
    })

    require("mini.statusline").setup({
      use_icons = vim.g.have_nerd_font,
    })

    -- Setup mini.pick
    local mini_pick = require("mini.pick")
    mini_pick.setup({
      window = {
        config = {
          border = "rounded", -- This adds border to the picker window
        },
      },
    })

    local pick = mini_pick.builtin
    vim.keymap.set("n", "<leader> ", pick.files, { desc = "Mini files" })
    vim.keymap.set("n", "<leader>mg", pick.grep_live, { desc = "Mini grep live" })
    vim.keymap.set("n", "<leader>mb", pick.buffers, { desc = "Mini buffers" })
    vim.keymap.set("n", "<leader>mh", pick.help, { desc = "Mini help" })
  end,
}
