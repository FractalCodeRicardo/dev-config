return {
   'nvim-treesitter/nvim-treesitter',
   build = ':TSUpdate',
   config = function()
      vim.print("Configurando treesitter");
      require('nvim-treesitter.configs').setup {
         highlight = {
            enabled = true
         }
      }
   end
}
