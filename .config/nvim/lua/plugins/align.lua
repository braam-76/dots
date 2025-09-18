return {
  'Vonr/align.nvim',
  branch = "v2",
  config = function()
    vim.keymap.set('v', 'ac', function()
      require 'align'.align_to_char({
        length = 1,
      })
    end, { desc = "align.nvim: [a]lign by [c]har", noremap = true, silent = true })
  end
}
