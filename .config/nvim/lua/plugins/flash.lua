return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", function() require("flash").jump() end,              mode = { "n", "x", "o" } },
      { "S", function() require("flash").treesitter() end,        mode = { "n", "x", "o" } },
      { "r", function() require("flash").remote() end,            mode = "o" },
      { "R", function() require("flash").treesitter_search() end, mode = { "o", "x" } },
    },
  },
}
