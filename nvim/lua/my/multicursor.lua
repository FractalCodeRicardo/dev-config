 -- 1. Keymap to - add the cursor positions
local cursors = {}

local function add_cursor()
  local cursor = vim.api.nvim_win_get_cursor(0)

  print("Cursor added: " .. vim.inspect(cursor))
  table.insert(cursors, cursor)
end

vim.keymap.set("n", "Q", add_cursor, {})


-- 2. Keymap to start/stop edition over the positions

local start_edition = false
local characters_added = 0

local function toggle_edition()
  if (#cursors == 0) then
    return
  end

  start_edition = not start_edition

  if (start_edition) then
    print("Start editing")
  else
    cursors = {}
    characters_added = 0
    print("Edition Ended")
  end
end

vim.keymap.set("n", "S", toggle_edition, {})


-- 4. Append the characters to the positions

local function is_current_cursor(cursor)
  local current = vim.api.nvim_win_get_cursor(0)
  return current[1] == cursor[1]
end

local function add_character_cursor(cursor, character)
  print("Edition cursor " .. vim.inspect(cursor) .. " " .. character)

  local row = cursor[1] - 1
  local column = cursor[2] + characters_added - 1

  vim.api.nvim_buf_set_text(0, row, column, row, column, {character})
end

local function add_character(character)
  characters_added = characters_added + 1
  for _, cursor in pairs(cursors) do
    if (not is_current_cursor(cursor)) then
     add_character_cursor(cursor, character)
    end
  end
end

-- 3. Autocommand to get the characters typed while editing
vim.api.nvim_create_autocmd('InsertCharPre', {
  callback = function ()
    if (not start_edition) then
      return
    end

    local character = vim.v.char
    print(character .. "typed.")

    vim.schedule(function ()
     add_character(character)
    end)

  end
})

