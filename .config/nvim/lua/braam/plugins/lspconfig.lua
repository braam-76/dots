vim.pack.add {
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "*" },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>')

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end
})

require "blink.cmp".setup {
  signature = { enabled = true },
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
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim", "require" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable {
  "lua_ls",
  "zls",
  "gopls"
}
