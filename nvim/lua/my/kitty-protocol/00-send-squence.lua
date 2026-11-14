local tty = vim.tty
local api = vim.api

local command = "\027[5n"
-- tty.request(command, {}, function (res)
--  print(res) -- Esc[0n  
-- end)
--

api.nvim_create_autocmd("TermResponse", {
  callback = function (res)
    print(vim.inspect(res))
  end
})

api.nvim_ui_send(command)

