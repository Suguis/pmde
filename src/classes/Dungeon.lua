--- A dungeon that contains floors and Pokémon
-- @classmod Dungeon
local Dungeon = _C.Object:new()
Dungeon.__index = Dungeon

--- Creates a new dungeon
-- @tparam string name the name of the Dungeon.
-- @tparam number total_floors the number of floors.
-- @tparam number width the width of each Floor in the dungeon, in cells.
-- @tparam number height the height of each Floor in the dungeon, in cells.
-- @tparam string tileset_id the name of the tileset.
-- @treturn Dungeon the new dungeon.
function Dungeon:new(name, total_floors, width, height, tileset_id)
  local floors = {}
  for i = 1, total_floors do
    floors[i] = _C.Floor:new(width, height)
  end

  return setmetatable({
    name = name,
    floors = floors,
    tileset = love.graphics.newImage("res/tilesets/" .. tileset_id .. ".png"),
  }, self)
end

--- Draws a floor of the dungeon.
-- @tparam number floor the number of the floor to draw (absolute value).
-- @raise an error if the floor doesn't exist in the dungeon.
function Dungeon:get_floor(floor)
  assert(floor, "The floor doesn't exists")
  return self.floors[floor]
end

--- Returns the reference to the tileset that is using the dungeon.
-- @treturn Image the tileset that the Dungeon is using.
function Dungeon:get_tileset()
  return self.tileset
end

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function Dungeon:__tostring()
  return string.format("Dungeon = {name = %s, total_floors = %s}",
      self.name, self.total_floors)
end

return Dungeon
