
-- 1. Create namespace and highlights

local ns = vim.api.nvim_create_namespace("CursorAnimation")
vim.api.nvim_set_hl(0, "CursorAnimationStart", {
  bg = "#42f56c"
})


vim.api.nvim_set_hl(0, "CursorAnimationFade", {
  bg = "#2a9c45"
})


vim.api.nvim_set_hl(0, "CursorAnimationEnd", {
  bg = "#000000"
})

-- 2. Create function to create/update extmar

function update_mark(id, row, col, hl) 
   pcall(vim.api.nvim_buf_set_extmark,0, ns, row, col, {
    id = id,
    end_row = row,
    end_col = col +1,
    hl_group = hl
  })
end

function create_mark(row, col, hl) 
  local id = vim.api.nvim_buf_set_extmark(0, ns, row, col, {
    end_row = row,
    end_col = col +1,
    hl_group = hl
  })

  return id
end

function delete_mark(id) 

  vim.defer_fn(function ()
    pcall(vim.api.nvim_buf_del_extmark,0, ns, id)
  end, 600)
end

-- 3. Create function to validate positions

function is_valid_pos(row, col) 
  local line_count = vim.api.nvim_buf_line_count(0)

  if (row < 0 or row >= line_count) then
    return false
  end

  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

  if (line == nil) then
    return false
  end

  if (col < 0 or col >= #line) then
    return false
  end

  return true
end


-- 5. Create function to animate the cursor

function animate(id, row, col) 
  vim.defer_fn(function ()
    update_mark(id, row, col, "CursorAnimationFade")
  end, 200)


  vim.defer_fn(function ()
    update_mark(id, row, col, "CursorAnimationEnd")
  end, 400)
    
end
-- 4. Bind extmark function to CursorMoved autocommand

vim.api.nvim_create_autocmd('CursorMoved',{
  callback = function ()

    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1] - 1
    local col = pos[2]

    if (not is_valid_pos(row, col)) then
      return
    end

    local id = create_mark(row, col, "CursorAnimationStart")
    animate(id, row, col)
    delete_mark(id)
  end
})

-- 6. Replace extmark method with pcall to smooth errors
-- 7. Delete extmark at the end
