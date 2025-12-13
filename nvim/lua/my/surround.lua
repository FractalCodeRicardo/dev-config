
function surround(start, close)
  vim.cmd("normal! yiw")
  local word = vim.fn.getreg('"')
  local command = string.format("ciw%s%s%s", start, word,close) 
  vim.cmd("normal! " .. command)
end

function event(start, close, keymap)
  vim.keymap.set("n", keymap, function()
    surround(start, close)
  end, { desc = "Surround " .. start .. close })
end

function init()
  event("(", ")", "()")
  event("{", "}", "{}")
  event("[", "]", "[]")
end

init();

