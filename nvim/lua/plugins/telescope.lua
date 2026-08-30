return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require("telescope.builtin") 

    vim.keymap.set('n', '<C-p>', telescope.find_files, options)
  end
}
