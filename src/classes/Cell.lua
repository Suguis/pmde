--- @class Cell the minimum unit of a floor object.
local Cell = _C.Object:new()
Cell.__index = Cell

-- Static atributes

--- A table to save all Cell quads in the form: Cell.quads[type][bitvalue][alt]
Cell.quads = {}

-- We use bitdef table data to make Cell.quads.
local bitdef = require "src.modules.bitdef"
for t = 1, #bitdef do
    Cell.quads[t] = {}
    for bit = 0, 255 do
        if bitdef[t][bit] then
            Cell.quads[t][bit] = {}
            -- For each tile that exists to represent same bit value
            for i = 0, bitdef[t][bit][3] do
                Cell.quads[t][bit][i + 1] =
                    love.graphics.newQuad(
                    globals.CELL_SIZE * (bitdef[t][bit][2] - 1 + i * 3),
                    globals.CELL_SIZE * (bitdef[t][bit][1] - 1),
                    globals.CELL_SIZE,
                    globals.CELL_SIZE,
                    globals.TILESET_WIDTH,
                    globals.TILESET_HEIGHT
                )
            end
        end
    end
end

--- Creates a Cell.
--- @param type number the type of the Cell. Must be 0 (for wall) or 1 (for
-- floor).
-- @raise an error if the type or the bit_value are incorrect.
function Cell:new(type)
    assert(type >= 1 and type <= 2, "Incorrect type, must be 1 (wall) or 2 (floor)", 2)

    local new = setmetatable(_C.Object:new(), self)

    new.type = type
    new.bit_value = nil

    return new
end

--- Returns the bit value value of the Cell.
--- @return number the bit value value assigned to this csell.
function Cell:get_bit_value()
    return self.bit_value
end

--- Sets the new bit value value.
--- @param bit_value number the new bit_value. Must be a number between 0
-- and 255, both included.
-- @raise an error if the new value is incorrect.
function Cell:set_bit_value(bit_value)
    assert(bit_value >= 0 and bit_value < 256, "Incorrect bit value.")
    self.bit_value = bit_value
end

--- Returns the type of the Cell.
--- @return number the type assigned to this Cell.
function Cell:get_type()
    return self.type
end

--- Sets the new type of this Cell.
--- @param type number the new type of the Cell. Must be 0 (for wall) or 1 (for floor).
function Cell:set_type(type)
    assert(type >= 1 and type <= 2, "Incorrect type, must be 1 (wall) or 2 (floor)", 2)
    self.type = type
end

--- Returns the quad of the Cell
--- @return Quad a love2d quad associated to the corresponding tile of the Cell.
function Cell:get_quad()
    return self.quad
end

--- Updates the tile of the Cell according to its atributes.
--- @param alt number|nil an specific alternative of tile. If it's not specified, a random variation will be selected.
function Cell:update_quad(alt)
    -- If doesn't exist a representation of that Cell
    if Cell.quads[self.type][self.bit_value] then
        self.quad =
            Cell.quads[self.type][self.bit_value][
            alt or math.random(1, math.max(1, #Cell.quads[self.type][self.bit_value]))
        ]
    else
        self.quad = Cell.quads[self.type][255][1]
    end
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Cell:__tostring()
    return string.format("Cell = {type = %s}", self.type)
end

return Cell
