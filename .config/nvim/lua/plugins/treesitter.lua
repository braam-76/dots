return {
  {
    "nvim-treesitter/nvim-treesitter", 
    branch = 'master',
    lazy = false, 
    build = ":TSUpdate",
    
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = { "lua", "javascript", "c", "cpp", "clojure", "json", "java", "vimdoc", "markdown" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
