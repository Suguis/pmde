 local Pokemon = _C.Object:new()
Pokemon.__index = Pokemon

function Pokemon:new(number, level)
  return setmetatable({
    number = number,
    level = level
  }, self)
end

function Pokemon:__tostring()
  return string.format("Pokemon = {number = %d, level = %d}", self.number, self.level)
end

return Pokemon
