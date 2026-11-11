local api = vim.api
local async = vim.async
local task = nil

local ui = require("vim._core.ui2")

ui.enable({
  enable = true,
  msg = {
    targets = {
      progress = "msg"
    }
  }
})

local frames = { '⠋', '⠙', '⠹', '⠸', '⠼','⠴', '⠦', '⠧', '⠇', '⠏' }
local frame = 0
local i_frame = 0

local message_id = nil
function show_progress(percent, title, is_running)
  local status = "success"
  if is_running then
    status = "running"
  end

  if i_frame == #frames then
    i_frame = 0
  end

  i_frame = i_frame + 1

  message_id = api.nvim_echo({ { title } }, false, {
    id = message_id,
    percent = percent,
    source = "screen-scroll",
    status = status,
    title = frames[i_frame] .. " Scroll",
    kind = "progress"
  })
end


function get_topline()
  local win = api.nvim_get_current_win()

  if not api.nvim_win_is_valid(win) then
    return nil
  end
  local height = api.nvim_win_get_height(win)
  local row = api.nvim_win_get_cursor(win)[1]

  local topline = row - (height / 2)
  topline = math.floor(topline)
  return topline
end

function animate(from, to)
  if task ~=nil and not task:completed() then
    task:close()
  end

  if from == to then
    return
  end

  local step = 1

  if from > to then
    step = -1
  end

  
  task = async.run(function()

    async.sleep(1000)

    local total = math.abs(from - to)
    local progress = 0
    local i = 0
    local time = 10

    show_progress(0, "Start scrolling", true)
    for row = from, to, step do
      vim.fn.winrestview({
        topline = row
      })
      async.sleep(10 + progress * 2)

      show_progress(progress, "Scrolling", true)
      i = i + 1
      progress = math.floor((i / total) * 100)
    end

    show_progress(100, "Scrolling finish", false)

  end)

  task:on_complete(function (err, res)
    if err ~= nil then
      -- error(err)
    end
  end)
end

function move_to_topline()
  local newtopline = get_topline()

  if newtopline == nil or newtopline < 0 then
    return
  end

  local oldtopline = vim.fn.winsaveview().topline
  animate(oldtopline, newtopline)
end

api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    move_to_topline()
  end
})
