local api = vim.api
local fn = vim.fn
local img = vim.ui.img
local net = vim.net

local function parse_image(line)
  local l = vim.trim(line)
  local is_image = l:sub(1, 2) == "!["

  if not is_image then
    return nil
  end

  local image = vim.split(l, "%(")[2]
  image = image:sub(1, #image - 1)
  return image
end

local function is_web(file)
  return file:sub(1, 4) == "http"
end

local function get_blob(file, callback)
  if not is_web(file) then
    callback(fn.readblob(file))
    return
  end

  net.request(
    file,
    {},
    function(err, res)
      callback(res.body)
    end
  )
end

api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    local win = api.nvim_get_current_win()
    if not api.nvim_win_is_valid(win) then
      return
    end

    local line = api.nvim_get_current_line()
    local file = parse_image(line)

    if file == nil then
      return
    end

    if not is_web(file) and fn.filereadable(file) ~= 1 then
      return
    end

    get_blob(file, function(content)
      vim.schedule(function()
        img.set(content, {
          col = 55,
          row = 1,
          width = 35,
          height = 15
        })
      end)
    end)
  end
})
