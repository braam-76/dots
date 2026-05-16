vim.pack.add({
  { src = "https://github.com/yetone/avante.nvim" },

  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },

  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

vim.opt.laststatus = 3
vim.opt.cmdheight = 0

require("render-markdown").setup({
  file_types = { "markdown", "Avante" },
})

require("avante").setup({
  instructions_file = "avante.md",
  provider = "routerai",
  providers = {
    routerai = {
      __inherited_from = "openai",
      endpoint = "https://routerai.ru/api/v1/",
      model = "anthropic/claude-sonnet-4.6",
      disabled_tools = { "python" },
      model_names = {
        "qwen/qwen3-coder-plus",
        "anthropic/claude-sonnet-4.6",
        "anthropic/claude-haiku-4.5",
      },
      timeout = 30000,
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 16000,
      },
      extra_headers = {
        ["HTTP-Referer"] = "https://github.com/yetone/avante.nvim",
        ["X-Title"] = "Avante.nvim",
      },
    },
  },
  behaviour = {
    auto_approve_tool_permissions = false,
  },
})
