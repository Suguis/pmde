--- @class Floor a randomly generated Floor with items and Pokémon.
local Floor = _C.Object:new()
Floor.__index = Floor

local bit = require "bit"

-- Static atributes
Floor.bit_values = {
    [-1] = {[-1] = 128, [0] = 64, [1] = 32},
    [0] = {[-1] = 1, [0] = 0, [1] = 16},
    [1] = {[-1] = 2, [0] = 4, [1] = 8}
}

--- A cell that represents all cells outside the Dungeon. It is unbreakable.
Floor.void_cell = _C.Cell:new(1)
Floor.void_cell:set_bit_value(255)

--- Creates a new randomly generated Floor.
--- @param width number the width of the Floor, in cells.
--- @param height number the height of the Floor, in cells.
--- @return Floor a new randomly generated Floor
function Floor:new(width, height)
    local new = setmetatable(_C.Object:new(), self)

    local grid = {
        {2, 2, 2},
        {2, 2, 2},
        {2, 2, 2}
    }

    for i = 1, #grid do
        for j = 1, #grid[i] do
            local c = _C.Cell:new(math.random(1, 2))
            c:set_type(grid[i][j])
            grid[i][j] = c
        end
    end

    new.width = width
    new.height = height
    new.grid = grid
    new.pokemons = {}
    new.items = {}

    new:update_bit_values()

    return new
end

--- Returns the cell at a specified position.
--- @param x number the x coordinate.
--- @param y number the y coordinate.
--- @return Cell the Cell at the specified position, or void_cell if the Cell
--- doesn't exists.
--- @overload fun(coordinates:Vector):Cell
function Floor:get_cell(x, y)
    if type(x) == "table" then -- Overload
        local coordinates = x
        x, y = coordinates:get_x(), coordinates:get_y()
    end
    return self.grid[x] and self.grid[x][y] or Floor.void_cell
end

--- Updates the bit value of all cells.
function Floor:update_bit_values()
    local new_value
    -- Values to calculate the bit value.
    -- We start from zero to the size + 1 because we also need to update
    -- the bit value of the surrounding cells, althought is impossible to
    -- destroy them, and they will always be walls.
    for i = 0, self.width + 1 do
        for j = 0, self.height + 1 do
            new_value = 0
            for x = -1, 1 do
                for y = -1, 1 do
                    if self:get_cell(i + x, j + y):get_type() == self:get_cell(i, j):get_type() then
                        new_value = bit.bor(new_value, self.bit_values[x][y])
                    end
                end
            end

            -- If the cell doesnt exists (it's using the void_cell constant cell) we
            -- create a new cell on that position
            if self:get_cell(i, j) == Floor.void_cell then
                if new_value ~= 255 then
                    if not self.grid[i] then
                        self.grid[i] = {}
                    end
                    self.grid[i][j] = _C.Cell:new(1)
                    self:get_cell(i, j):set_bit_value(new_value)
                    self:get_cell(i, j):update_quad()
                end
            else -- A cell that exists on the grid
                self:get_cell(i, j):set_bit_value(new_value)
                self:get_cell(i, j):update_quad()
            end
        end
    end
    Floor.void_cell:update_quad(1)
end

--- Adds a Pokemon on the Floor
--- @param pokemon DungeonPokemon the Pokemon
function Floor:add_pokemon(pokemon)
    table.insert(self.pokemons, pokemon)
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Floor:__tostring()
    local string_builder = {}
    local rep = {"#", "."} -- Representation of types

    table.insert(
        string_builder,
        -- -1 because surrounding cells
        string.format("Floor = {width = %d, height = %d}\n", #self.grid - 1, #self.grid[1] - 1)
    )

    for i = 0, #self.grid do
        for j = 0, #self.grid[i] do
            table.insert(string_builder, rep[self.grid[i][j]:get_type()])
        end
        table.insert(string_builder, "\n")
    end

    return table.concat(string_builder, "")
end

return Floor
