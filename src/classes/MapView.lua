--- A MapView that controls a specific view of a Floor
-- @classmod MapView
local MapView = _C.Object:new()
MapView.__index = MapView

local mfloor = math.floor

--- Creates a new MapView.
-- @tparam Vector pos the vector of the coordinates that the MapView is going to
-- put in the center.
-- @tparam Floor floor the Floor on which the MapView is going to focus.
-- @tparam Image tileset the Image that the MapView buffer is going to use.
-- @treturn MapView the new MapView.
function MapView:new(pos, floor, tileset)
  self.batch = love.graphics.newSpriteBatch(tileset, 512, "static")  -- TODO: this needs to be static

  local toRet = setmetatable({
    pos = _C.Vector:new(pos.x - (love.graphics.getWidth() / 2 - globals.CELL_SIZE / 2)
        / (globals.CELL_SIZE),
        pos.y - (love.graphics.getHeight() / 2 - globals.CELL_SIZE / 2)
        / (globals.CELL_SIZE)),
    floor = floor,
  }, self)

  toRet:update()

  return toRet
end

--- Moves the view
-- @tparam Vector dv the displacement Vector.
function MapView:move(dv)
  local oldPos = self.pos

  self.pos = self.pos + dv

  -- Only update if we move one tile
  if self.pos ~= oldPos then
    self:update()
  end

  self:updateInstances()
end

--- Updates the draw positions of the MapView instances.
--
-- This functions requires to call it manually after adding into the Floor the
-- corresponding instances.
function MapView:updateInstances()
  for i = 1, #self.floor.pokemons do
    self.floor.pokemons[i]:moveDraw(self.pos * -globals.CELL_SIZE)
  end
end

--- Updates the view to adecuate it to the coordinates.
function MapView:update()
  self.batch:clear()
  for x = 1, globals.TILES_DISPLAY_WIDTH do
    for y = 1, globals.TILES_DISPLAY_HEIGHT do
      self.batch:add(self.floor:getCell(
          x + mfloor(self.pos.x), y + mfloor(self.pos.y)):getQuad(),
          (x - 1) * globals.CELL_SIZE, (y - 1) * globals.CELL_SIZE)
    end
  end
  self.batch:flush()
end

--- Draws the cells of the floor
-- @tparam Texture the Texture from which the tiles are drawn
function MapView:draw()
  love.graphics.draw(self.batch,
      mfloor(-(self.pos.x % 1) * globals.CELL_SIZE),
      mfloor(-(self.pos.y % 1) * globals.CELL_SIZE))
  for i = 1, #self.floor.pokemons do
    self.floor.pokemons[i]:draw()
  end
end

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function MapView:__tostring()
  return string.format("MapView = {pos = %s, width = %d, height = %d}",
      self.pos.__tostring(), #self.grid, #self.grid[1])
end

return MapView
