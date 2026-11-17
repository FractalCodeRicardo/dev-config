local M = {}

M.bytes = function(size)
  -- im going to transform this into a circle
  local half = size / 2
  local bytes = ""

  local r = math.random(255)
  local g = math.random(255)
  local b = math.random(255)

  for x = -half, half - 1 do
    for y = -half, half - 1 do
      local radius = math.sqrt(x * x + y * y)

      local byte = string.char(0, 0, 0, 0)

      if radius <= half then
        byte = string.char(r, g, b, 200)
      end

      bytes = bytes .. byte
    end
  end

  return bytes
end


return M
