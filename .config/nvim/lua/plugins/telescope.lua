return {
  {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      layout_stategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.75,
        },
      },
      sorting_strategy = "ascending",
    },
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files,
        { desc = '[f]ind [f]iles (Telescope)' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep,
        { desc = '[f]ind with live [g]rep (Telescope)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers,
        { desc = '[f]ind [b]uffers (Telescope)' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags,
        { desc = '[f]ind [h]elp tags (Telescope)' })
  end
  },
}
