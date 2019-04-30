--- @class Dungeon a Dungeon that contains floors and Pokémon
local Dungeon = _C.Object:new_void()
Dungeon.__index = Dungeon

--- Creates a new Dungeon
--- @param name string the name of the Dungeon.
--- @param total_floors number the number of floors.
--- @param width number the width of each floor in the Dungeon, in Cells.
--- @param height number the height of each floor in the Dungeon, in Cells.
--- @param tileset_id string the name of the tileset.
--- @return Dungeon the new Dungeon.
function Dungeon:new(name, total_floors, width, height, tileset_id)
    local new = setmetatable(_C.Object:new(), self)

    local floors = {}
    for i = 1, total_floors do
        floors[i] = _C.Floor:new(width, height)
    end

    local tileset = love.graphics.newImage("res/tilesets/" .. tileset_id .. ".png")

    new.name = name
    new.floors = floors
    new.tileset = tileset
    new.view = _C.MapView:new(_C.Vector:new(0, 0), floors[1], tileset)

    return new
end

function Dungeon:new_void()
    return setmetatable(_C.Object:new_void(), self)
end

--- Draws a floor of the Dungeon.
--- @param floor number the number of the floor to draw (absolute value).
--- @return Floor the floor of the number passed from argument.
function Dungeon:get_floor(floor)
    assert(floor, "The floor doesn't exists")
    return self.floors[floor]
end

--- Returns the reference to the tileset that is using the Dungeon.
--- @return Image the tileset that the Dungeon is using.
function Dungeon:get_tileset()
    return self.tileset
end

--- Gets the MapView of the Dungeon
--- @return MapView the MapView of the Dungeon
function Dungeon:get_view()
    return self.view
end

--- Draws the MapView of the dungeon, and the Pokemon and the Items of it's floor (the MapView's floor).
function Dungeon:draw()
    self.view:draw()
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Dungeon:__tostring()
    return string.format("Dungeon = {name = %s, total_floors = %s}", self.name, self.total_floors)
end

return Dungeon
