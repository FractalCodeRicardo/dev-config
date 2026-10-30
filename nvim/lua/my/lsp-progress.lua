local ui = require("vim._core.ui2")
local api = vim.api
local async = vim.async

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
local function progress(percent, title, is_running)
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
    source = "lsp-progress",
    status = status,
    title = frames[i_frame] .. " LSP",
    kind = "progress"
  })
end

api.nvim_create_autocmd("LspProgress", {
  callback = function(args)
    local value = args.data.params.value

    if value == nil then return end

    local title = value.title
    local percent = value.percentage or 0
    local is_running = true

    if percent > 95 and percent <= 100 then
      is_running = false
    end

    if percent > 0 then
      progress(percent, title, is_running)
    end
  end
})
