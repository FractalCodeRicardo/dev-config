return {
   'nvim-treesitter/nvim-treesitter',
   build = ':TSUpdate',
   config = function()
      vim.print("Configurando treesitter");
      require('nvim-treesitter.configs').setup {
         highlight = {
            enabled = true
         },
         indent = {
            enabled = true
         }
      }

      vim.o.foldmethod = 'manual'
      vim.o.foldenable = false
   end
}
