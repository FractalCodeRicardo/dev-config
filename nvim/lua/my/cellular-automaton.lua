
-- 1. Slide DONE!
-- 2. Random swap DONE!
-- 3. Bouncing code DONE!
-- 4. Rotate code DONE!
-- 5. Explosion DONE!
-- 6. Particles DONE!
-- 7. Ants
local slide = {
  fps = 50,
  name = 'slide',
}

slide.update = function(grid)
  for i = 1, #grid do
    local prev = grid[i][#(grid[i])]
    for j = 1, #(grid[i]) do
      grid[i][j], prev = prev, grid[i][j]
    end
  end
  return true
end


local swap_random = {
  fps = 15,
  name = 'swap_random',
}

swap_random.update = function(grid)
  for y = 1, #grid do
    for x = 1, #grid[1] do
      local ry = math.random(#grid)
      local rx = math.random(#grid[1])
      grid[y][x] = grid[ry][rx]
    end
  end
  return true
end


local function create_cells(grid)
  local cells = {}
  for y = 1, #grid do
    for x = 1, #grid[1] do
      local cell = {
        pos = { x = x, y = y },
        dir = { x = 1, y = 1 },
        char = grid[y][x]
      }

      table.insert(cells, cell)
    end
  end

  return cells
end


local function clear(grid)
  local cells = {}
  for y = 1, #grid do
    for x = 1, #grid[1] do
      grid[y][x] = {
        char = " "
      }
    end
  end
end

local bouncing = {
  fps = 50,
  name = 'bouncing',
}

local cells = nil
bouncing.update = function(grid)
  if cells == nil then
    cells = create_cells(grid)
  end

  local h = #grid
  local w = #grid[1]

  clear(grid)
  for _, c in pairs(cells) do
    local new_pos = {
      x = c.pos.x + c.dir.x,
      y = c.pos.y + c.dir.y
    }

    if new_pos.x < 1 or new_pos.x > w then
      c.dir.x = c.dir.x * -1;
    end

    if new_pos.y < 1 or new_pos.y > h then
      c.dir.y = c.dir.y * -1;
    end

    new_pos = {
      x = c.pos.x + c.dir.x,
      y = c.pos.y + c.dir.y
    }

    c.pos = new_pos
    -- print(vim.inspect(c))
    grid[c.pos.y][c.pos.x] = c.char
  end
  return true
end


local rotation = {
  fps = 50,
  name = 'rotation',
}

local angle = 0
rotation.update = function(grid)
  if cells == nil then
    cells = create_cells(grid)
  end

  local h = #grid
  local w = #grid[1]

  local cx = w / 4
  local cy = h / 2

  clear(grid)
  angle = angle + 0.08
  for _, c in pairs(cells) do

    local x = c.pos.x - cx
    local y = c.pos.y - cy

    local rx = x * math.cos(angle) - y * math.sin(angle)
    local ry = x * math.sin(angle) - y * math.cos(angle)

    rx = math.floor(rx + cx)
    ry = math.floor(ry + cy)

    if rx > 0 and rx < w and ry > 0 and ry < h then
      grid[ry][rx] = c.char
    end

  end
  return true
end

local explosion = {
  fps = 50,
  name = 'explosion',
}

local progress = 0
explosion.update = function (grid)
  if cells == nil then
    cells = create_cells(grid)
  end

  progress = progress + 0.05

  clear(grid)

  local h = #grid
  local w = #grid[1]

  local cx = w / 4
  local cy = h / 2

  for _, c in pairs(cells) do
    local tx = c.pos.x - cx
    local ty = c.pos.y - cy

    local x = math.floor(cx + tx * progress)
    local y = math.floor(cy + ty * progress)

    if x > 0 and x <= w and y > 0 and y <= h then
      grid[y][x] = c.char
    end
  end

  if progress >=3 then
    progress = 0
  end
  return true
end


local particles = {
  fps = 50,
  name = 'particles',
}

local function init_cells(cells)
 for _, c in pairs(cells) do
   c.dir = {
     x = math.random(),
     y = math.random()
   }
   c.posf = {
     x = c.pos.x,
     y = c.pos.y
   }
 end
end

particles.update = function(grid)
  if cells == nil then
    cells = create_cells(grid)
    init_cells(cells)
  end

  local h = #grid
  local w = #grid[1]

  clear(grid)
  for _, c in pairs(cells) do
    local new_pos = {
      x = c.posf.x + c.dir.x,
      y = c.posf.y + c.dir.y
    }

    if new_pos.x < 1 or new_pos.x > w then
      c.dir.x = c.dir.x * -1;
    end

    if new_pos.y < 1 or new_pos.y > h then
      c.dir.y = c.dir.y * -1;
    end

    new_pos = {
      x = c.posf.x + c.dir.x,
      y = c.posf.y + c.dir.y
    }

    c.pos = {
      x = math.floor(new_pos.x),
      y = math.floor(new_pos.y)
    }
    c.posf = new_pos
    -- print(vim.inspect(c))
    grid[c.pos.y][c.pos.x] = c.char
  end
  return true
end



local ants = {
  fps = 15,
  name = 'ants',
}

ants.update = function(grid)
  if cells == nil then
    cells = create_cells(grid)
  end

  local h = #grid
  local w = #grid[1]

  local directions = {0, 1, -1}
  for _, c in pairs(cells) do
    local dir = {
      x = directions[math.random(#directions)],
      y = directions[math.random(#directions)]
    }

    c.dir = dir

    local new_pos = {
      x = c.pos.x + c.dir.x,
      y = c.pos.y + c.dir.y
    }

    if new_pos.x < 1 or new_pos.x > w then
      c.dir.x = c.dir.x * -1;
    end

    if new_pos.y < 1 or new_pos.y > h then
      c.dir.y = c.dir.y * -1;
    end

    new_pos = {
      x = c.pos.x + c.dir.x,
      y = c.pos.y + c.dir.y
    }

    c.pos = new_pos
    -- print(vim.inspect(c))
    if c.char.char ~= nil then
      grid[c.pos.y][c.pos.x] = c.char
    end
  end
  return true
end



local plugin = require("cellular-automaton")
plugin.register_animation(slide)
plugin.register_animation(swap_random)
plugin.register_animation(bouncing)
plugin.register_animation(rotation)
plugin.register_animation(explosion)
plugin.register_animation(particles)
plugin.register_animation(ants)
