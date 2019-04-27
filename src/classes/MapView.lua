--- @class MapView a MapView that shows a specific view of a Floor
local MapView = _C.Object:new()
MapView.__index = MapView

local mfloor = math.floor

--- Creates a new MapView.
--- @param pos Vector the Vector of the coordinates that the MapView is going to put in the center.
--- @param floor Floor the Floor on which the MapView is going to focus.
--- @param tileset Image the Image that the MapView buffer is going to use.
--- @return MapView the new MapView.
function MapView:new(pos, floor, tileset)
    self.batch = love.graphics.newSpriteBatch(tileset, 512, "static") -- TODO: this needs to be static

    local to_ret =
        setmetatable(
        {
            pos = _C.Vector:new(
                pos.x - (love.graphics.getWidth() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE),
                pos.y - (love.graphics.getHeight() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
            ),
            floor = floor
        },
        self
    )

    to_ret:update()

    return to_ret
end

--- Moves the view
--- @param dv Vector the displacement Vector.
function MapView:move(dv)
    local old_pos = self.pos

    self.pos = self.pos + dv

    -- Only update if we move one tile
    if self.pos ~= old_pos then
        self:update()
    end

    self:update_instances()
end

--- Returns the position that the MapView is capturing
--- @return Vector the position that the MapView is capturing
function MapView:get_position()
    return self.pos
end

--- Sets the new position for the MapView
--- @param pos Vector the new MapView position to capture
function MapView:set_position(pos)
    self.pos.x = pos.x - (love.graphics.getWidth() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
    self.pos.y = pos.y - (love.graphics.getHeight() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
    self:update()
end

--- Updates the draw positions of the MapView instances.
--- This function requires to call it manually after adding into the Floor the
--- corresponding instances.
function MapView:update_instances()
    for i = 1, #self.floor.pokemons do
        self.floor.pokemons[i]:move_draw_pos(self.pos * -globals.CELL_SIZE)
    end
end

--- Updates the view to adecuate it to the coordinates.
function MapView:update()
    self.batch:clear()
    for x = 1, globals.TILES_DISPLAY_WIDTH do
        for y = 1, globals.TILES_DISPLAY_HEIGHT do
            self.batch:add(
                self.floor:get_cell(x + mfloor(self.pos.x), y + mfloor(self.pos.y)):get_quad(),
                (x - 1) * globals.CELL_SIZE,
                (y - 1) * globals.CELL_SIZE
            )
        end
    end
    self.batch:flush()
end

--- Draws the cells of the Floor
--- @param the Texture Texture from which the tiles are drawn
function MapView:draw()
    love.graphics.draw(
        self.batch,
        mfloor(-(self.pos.x % 1) * globals.CELL_SIZE),
        mfloor(-(self.pos.y % 1) * globals.CELL_SIZE)
    )
    for i = 1, #self.floor.pokemons do
        self.floor.pokemons[i]:draw()
    end
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function MapView:__tostring()
    return string.format(
        "MapView = {pos = %s, width = %d, height = %d}",
        self.pos.__tostring(),
        #self.grid,
        #self.grid[1]
    )
end

return MapView
