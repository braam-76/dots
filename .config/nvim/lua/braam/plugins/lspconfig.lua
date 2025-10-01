vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "*" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/DrKJeff16/wezterm-types" },
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "wezterm-types", mods = { "wezterm" } },
  },
})

require("blink.cmp").setup({
  signature = { enabled = true },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = {
      auto_show = true,
      draw = {
        treesitter = { "lsp" },
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
      },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "gopls",
  "jdtls",
  "pyright",

  "clangd",
  "cmake", -- NOTE: remember to install 'cmake-language-server' with pip on new system
})
