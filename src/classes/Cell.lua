--- The minimum unit of a Floor.
-- @classmod Cell
local Cell = _C.Object:new()
Cell.__index = Cell

-- Static atributes
Cell.quads = {}  -- A table to save all cell quads in the form: quads[type][bitvalue][alt]

local bitdef = require "src.bitdef"

for t = 1, #bitdef do
  Cell.quads[t] = {}
  for bit = 0, 255 do
    if bitdef[t][bit] then
      Cell.quads[t][bit] = {}
      -- For each tile that exists to represent same bit value
      for i = 0, bitdef[t][bit][3] do
        Cell.quads[t][bit][i + 1] = love.graphics.newQuad(
            globals.CELL_SIZE * (bitdef[t][bit][2] - 1 + i * 3),
            globals.CELL_SIZE * (bitdef[t][bit][1] - 1),
            globals.CELL_SIZE, globals.CELL_SIZE,
            globals.TILESET_WIDTH, globals.TILESET_HEIGHT)
      end
    end
  end
end

--- Creates a Cell.
-- @tparam number type the type of the Cell. Must be 0 (for wall) or 1 (for
-- floor).
-- @raise an error if the type or the bitValue are incorrect.
function Cell:new(type)
  if type < 1 or type > 2 then
    error("Incorrect type, must be 1 (wall) or 2 (floor)", 2)
  end
  return setmetatable({
    type = type,
    bitValue = nil
  }, self)
end

--- Returns the bit value value of the Cell.
-- @return the bit value value assigned to this Cell.
function Cell:getBitValue()
  return self.bitValue
end

--- Sets the new bit value value.
-- @tparam bitValue number the new bitValue. Must be a number between 0
-- and 255, both included.
-- @raise an error if the new value is incorrect.
function Cell:setBitValue(bitValue)
  assert(bitValue >= 0 and bitValue < 256, "Incorrect bit value.")
  self.bitValue = bitValue
end

--- Returns the type of the Cell.
-- @treturn number the type assigned to this cell.
function Cell:getType()
  return self.type
end

--- Sets the new type of this Cell.
-- @tparam number type the new type of the Cell. Must be 0 (for wall) or 1 (for
-- floor).
-- @raise an error if the type is incorrect.
function Cell:setType(type)
  if type < 1 or type > 2 then
    error("Incorrect type, must be 1 (wall) or 2 (floor)", 2)
  end
  self.type = type
end

--- Returns the quad of the cell
-- @treturn Quad a love2d quad associated to the corresponding tile of the Cell.
function Cell:getQuad()
  return self.quad
end

--- Updates the tile of the Cell according to its atributes.
-- @tparam[opt] number alt an specific alternative of tile. If it's not
-- specified, a random variation will be selected.
function Cell:updateQuad(alt)
  -- If doesn't exist a representation of that cell
  if Cell.quads[self.type][self.bitValue] then
    self.quad = Cell.quads[self.type][self.bitValue]
    [alt or math.random(
      1, math.max(1, #Cell.quads[self.type][self.bitValue]))]
    else
      self.quad = Cell.quads[self.type][255][1]
    end
end

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function Cell:__tostring()
  return string.format("Cell = {type = %s}", self.type)
end

return Cell
