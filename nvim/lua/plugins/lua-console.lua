return {
  "yarospace/lua-console.nvim",
  lazy = true,
keys = { { '<leader>ok', desc = 'lua-console: toggle' } },
    opts = {
      buffer = {
        prepend_result_with = '=> ',
        save_path = vim.fn.stdpath('state') .. '/lua-console.lua',
        load_on_start = true, -- load saved session on first entry
        preserve_context = true, -- preserve context between executions
      },
      window = {
        border = vim.o.winborder, -- single|double|rounded
        height = 0.6, -- percentage of main window
      },
      mappings = {
        toggle = '<leader>ok',
        quit = 'q',
        eval = '<CR>',
        clear = 'C',
        messages = 'M',
        save = 'S',
        load = 'L',
        resize_up = '<C-Up>',
        resize_down = '<C-Down>',
        help = '?',
      },
    }
}
