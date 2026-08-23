
local window = require("window")
local preview = require("viewer")

local current_search = ""
local current_entries = {}


local function get_file_name(entry)
  return vim.split(entry, ":")[1]
end

local function get_row(entry)
  local split = vim.split(entry, ":")
  return tonumber(split[2])
end

local function get_names_as_set()
  local set = {}
  for _, e in pairs(current_entries) do
    local name = get_file_name(e)

    if not set[name] then
      set[name] = true
    end
  end

  return set
end

local function replace_file(old, new, file_name)
  local pattern = string.format("s/%s/%s/g", old, new)
  local command = string.format("sed -i %s %s", pattern, file_name)
  vim.fn.system(command)
end

local function replace_current_entries()
  local files = get_names_as_set()
  local old = window.get_search_string()
  local new = window.get_replace_string()
  for name, value in pairs(files) do
    replace_file(old, new, name)
  end

  window.mark_replaced(current_entries)
end

local function get_rg_entries(search)
  local command = string
      .format("rg --vimgrep --fixed-strings %s", search)

  local res = vim.fn.systemlist(command)
  return res
end


local function on_buffer_change()
  local search = window.get_search_string()

  print(search)
  if search == current_search then
    return
  end

  -- current_search = search
  local matches = get_rg_entries(search)
  window.append_entries(matches)
  current_entries = matches
end

local function show_preview()
  local line = window.get_cursor_line()

  if line == nil then
    preview.close()
    return
  end

  if line < 3 or line > #current_entries + 3 then
    preview.close()
    return
  end

  local index_entry = line - 3 + 1
  local entry = current_entries[index_entry]

  local file = get_file_name(entry)
  local row = get_row(entry)
  preview.open(file, row, 0)
end

vim.keymap.set("n", "fr", function()
  window.toogle()
end, {})

window.on_replace(replace_current_entries)
window.on_cursor_moved(show_preview)
window.on_buffer_change(on_buffer_change)
window.on_perform_close(function()
  preview.close()
end)
