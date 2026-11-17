-- In this file im going to place all the sequences
--
local M = {}
local api = vim.api
local id = 1


local cell_size = {
  w = 13,
  h = 32
}

M.create_image= function(bytes, size)
  local base64 = vim.base64.encode(bytes)
  local command = string.format(
    "\027_Ga=t,s=%i,v=%i,i=%i,p=2;%s\027\\",
    size,
    size,
    id,
    base64
  )

  local oldid = id
  id = id + 1

  api.nvim_ui_send(command)

  return oldid
end

M.move_cursor = function(x, y)
  local row = math.floor(y / cell_size.h)
  local column = math.floor(x / cell_size.w)
  local command = string.format(
    "\027[%i;%iH",
    row,
    column
  )

  api.nvim_ui_send(command)
end

M.place= function(imageid, x, y)
  local xoffset = math.floor(x % cell_size.w)
  local yoffset = math.floor(y % cell_size.h)
  local command = string.format(
    "\027_Ga=p,i=%i,p=1,C=1,X=%i,Y=%i,q=2\027\\",
    imageid,
    xoffset,
    yoffset
  )

  api.nvim_ui_send(command)
end


M.hide_cursor = function ()
 api.nvim_ui_send("\027[?25l") 
end

M.show_cursor = function ()
 api.nvim_ui_send("\027[?25h") 
end

return M
