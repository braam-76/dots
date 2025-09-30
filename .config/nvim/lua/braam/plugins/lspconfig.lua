vim.pack.add {
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "*" },
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

-- vim.lsp.config("lua_ls", {
--   cmd = { "lua-language-server" }, 
--   settings = {
--     Lua = {
--       runtime = { version = "LuaJIT" },
--       diagnostics = { globals = { "vim", "require" } },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       telemetry = { enable = false },
--     },
--   },
-- })
--
-- vim.lsp.config("rust_analyzer", {
--   cmd = { 'rust-analyzer' },
--   filetypes = { 'rust' },
--   root_markers = { "Cargo.toml", ".git" },
--   single_file_support = true,
--   settings = {
--     ['rust-analyzer'] = {
--       diagnostics = {
--         enable = true,
--       }
--     }
--   },
--   before_init = function(init_params, config)
--     if config.settings and config.settings['rust-analyzer'] then
--       init_params.initializationOptions = config.settings['rust-analyzer']
--     end
--   end,
-- })
--
--
-- vim.lsp.config("jdtls", {
--   cmd = { "jdtls" },
--   root_dir = function()
--     local root_file = vim.fs.find({ ".git", "gradlew", "mvnw" }, { upward = true })[1]
--
--     return root_file and vim.fs.dirname(root_file) or vim.fn.getcwd()
--   end,
--   filetypes = { "java" },
--   settings = {
--     java = vim.empty_dict(),
--   },
--   on_attach = function(client, bufnr)
--     -- custom keymaps or other setup here
--   end,
-- })

-- vim.lsp.config("sql", {
--   cmd = { "sql-language-server", 'up', '--method', 'stdio' },
--   filetypes = {"sql"},
-- })

-- vim.lsp.config("cmake", {
--   cmd = { "cmake-language-server" },
--   filetypes = { "cmake" },
--   root_dir = function()
--     local root_file = vim.fs.find({ "build/compile_commands.json", ".clang-format" }, { upward = true })[1]
--
--     return root_file and vim.fs.dirname(root_file) or vim.fn.getcwd()
--   end,
--   initialization_options = {
--     buildDirectory = "build",
--   },
-- })

vim.lsp.enable {
  "lua_ls",
  "zls",
  "gopls",
  "rust_analyzer",
  "jdtls",

  "clangd",
  "cmake" -- NOTE: remember to install 'cmake-language-server' with pip on new system
}
