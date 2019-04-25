--- A dungeon that contains floors and Pokémon
-- @classmod Dungeon
local Dungeon = _C.Object:new()
Dungeon.__index = Dungeon

--- Creates a new dungeon
-- @tparam string name the name of the Dungeon.
-- @tparam number totalFloors the number of floors.
-- @tparam number width the width of each Floor in the dungeon, in cells.
-- @tparam number height the height of each Floor in the dungeon, in cells.
-- @tparam string tilesetId the name of the tileset.
-- @treturn Dungeon the new dungeon.
function Dungeon:new(name, totalFloors, width, height, tilesetId)
  local floors = {}
  for i = 1, totalFloors do
    floors[i] = _C.Floor:new(width, height)
  end

  return setmetatable({
    name = name,
    floors = floors,
    tileset = love.graphics.newImage("res/tilesets/" .. tilesetId .. ".png"),
  }, self)
end

--- Draws a floor of the dungeon.
-- @tparam number floor the number of the floor to draw (absolute value).
-- @raise an error if the floor doesn't exist in the dungeon.
function Dungeon:getFloor(floor)
  assert(floor, "The floor doesn't exists")
  return self.floors[floor]
end

--- Returns the reference to the tileset that is using the dungeon.
-- @treturn Image the tileset that the Dungeon is using.
function Dungeon:getTileset()
  return self.tileset
end

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function Dungeon:__tostring()
  return string.format("Dungeon = {name = %s, totalFloors = %s}",
      self.name, self.totalFloors)
end

return Dungeon
