return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescope find files' },  mode = 'n', },
    { '<leader>fg', require('telescope.builtin').live_grep,  { desc = 'Telescope live grep' },   mode = 'n', },
    { '<leader>fb', require('telescope.builtin').buffers,    { desc = 'Telescope buffers' },     mode = 'n', },
    { '<leader>fh', require('telescope.builtin').help_tags,  { desc = 'Telescope help tags' },   mode = 'n', },

  }
}
