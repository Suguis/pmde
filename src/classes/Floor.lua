--- A randomly generated floor with items and Pokémon.
-- @classmod Floor
local Floor = _C.Object:new()
Floor.__index = Floor

local bit = require "bit"

-- Static variables
Floor.voidCell = _C.Cell:new(1)
Floor.voidCell:setBitValue(255)

--- Creates a new randomly generated floor.
-- @tparam number width the width of the floor, in cells.
-- @tparam number height the height of the floor, in cells.
-- @treturn Floor a new randomly generated floor
function Floor:new(width, height)
  local grid

  local g = {
    {2, 2, 2},
    {2, 2, 2},
    {2, 2, 2}
  }

  for i = 1, #g do
    for j = 1, #g[i] do
      local c = _C.Cell:new(math.random(1, 2))
      c:setType(g[i][j])
      g[i][j] = c
    end
  end

  grid = g

  local toRet = setmetatable({
    width = width,
    height = height,
    grid = grid,
    pokemons = {},
    items = {}
  }, self)

  toRet:updateBitValues()

  return toRet
end

--- Returns the cell at a specified position.
-- @tparam number x the x coordinate.
-- @tparam number y the y coordinate.
-- @treturn Cell the cell at the specified position, or voidCell if the cell
-- doesn't exists.
function Floor:getCell(x, y)
  return self.grid[x] and self.grid[x][y] or Floor.voidCell
end

local bitValues = {
  [-1] = { [-1] = 128, [0] = 64, [1] = 32 },
  [0] = { [-1] = 1, [0] = 0, [1] = 16 },
  [1] = { [-1] = 2, [0] = 4, [1] = 8}
}
--- Updates the bit value of all cells.
function Floor:updateBitValues()
  local newValue
  -- Values to calculate the bit value.
  -- We start from zero to the size + 1 because we also need to update
  -- the bit value of the surrounding cells, althought is impossible to
  -- destroy them, and they will always be walls.
  for i = 0, self.width + 1 do
    for j = 0, self.height + 1 do
      newValue = 0
      for x = -1, 1 do
        for y = -1, 1 do
          if self:getCell(i + x, j + y):getType()
              == self:getCell(i, j):getType() then
            newValue = bit.bor(newValue, bitValues[x][y])
          end
        end
      end

      -- If the cell doesnt exists (it's using the voidCell constant cell) we
      -- create a new cell on that position
      if self:getCell(i, j) == Floor.voidCell then
        if newValue ~= 255 then
          if not self.grid[i] then self.grid[i] = {} end
          self.grid[i][j] = _C.Cell:new(1)
          self:getCell(i, j):setBitValue(newValue)
          self:getCell(i, j):updateQuad()
        end
      else  -- A cell that exists on the grid
        self:getCell(i, j):setBitValue(newValue)
        self:getCell(i, j):updateQuad()
      end
    end
  end
  Floor.voidCell:updateQuad(1)
end

--- Adds a Pokémon on the Floor
-- @tparam DungeonPokemon pokemon the Pokémon
function Floor:addPokemon(pokemon)
  table.insert(self.pokemons, pokemon)
end


--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function Floor:__tostring()
  local stringBuilder = {}
  local rep = {"#", "."}  -- Representation of types

  table.insert(stringBuilder,
      -- -1 because surrounding cells
      string.format("Floor = {width = %d, height = %d}\n", #self.grid - 1, #self.grid[1] - 1))

  for i = 0, #self.grid do
    for j = 0, #self.grid[i] do
      table.insert(stringBuilder, rep[self.grid[i][j]:getType()])
    end
    table.insert(stringBuilder, "\n")
  end

  return table.concat(stringBuilder, "")

end

return Floor
