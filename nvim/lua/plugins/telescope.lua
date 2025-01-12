return {
   'nvim-telescope/telescope.nvim',
   dependencies = {
      'nvim-lua/plenary.nvim',
   },
   keys = {
      { '<C-f>', function() require('telescope.builtin').find_files() end, { desc = 'Find Files' } },
      { '<C-p>', function() require('telescope.builtin').live_grep() end,  { desc = 'Find Grep' } },
   }
}
