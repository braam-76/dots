return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',
    opts = {
      keymap     = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false } },
      sources    = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      fuzzy      = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },

    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
              }
            }
          }
        },
        zls    = {},
        gopls  = {},
        jdtls  = {},
      }
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        vim.lsp.config(server, config)
      end
    end
  }
}
