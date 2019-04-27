--- @class MapView a MapView that shows a specific view of a Floor
local MapView = _C.Object:new()
MapView.__index = MapView

local mfloor = math.floor

--- Creates a new MapView.
--- @param center Vector the Vector of the coordinates that the MapView is going to put in the center.
--- @param floor Floor the Floor on which the MapView is going to focus.
--- @param tileset Image the Image that the MapView buffer is going to use.
--- @return MapView the new MapView.
function MapView:new(center, floor, tileset)
    self.batch = love.graphics.newSpriteBatch(tileset, 512, "static") -- TODO: this needs to be static

    local to_ret =
        setmetatable(
        {
            center = center, -- The grid cell that the view is centering
            pos = _C.Vector:new( -- The position of the left-up corner
                center.x - 1 - (love.graphics.getWidth() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE),
                center.y - 1 - (love.graphics.getHeight() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
            ),
            floor = floor,
            step_current_frames = 0,
            step_total_frames = 12, -- 24 if normal speed
            step_vector = nil, -- Vector that the player moves each step
            step_final_center = nil -- Vector that will equals MapView center when it finishes the move
        },
        self
    )

    to_ret:update_batch()

    return to_ret
end

--- Moves the view inmediately (not use outside the class)
--- @param dv Vector the displacement Vector.
function MapView:move_inmediate(dv)
    local old_pos = self.pos

    self.pos = self.pos + dv
    self.center = self.center + dv / globals.CELL_SIZE

    -- Only update if we move one tile
    if self.pos ~= old_pos then
        self:update_batch()
    end
end

--- Begins the move of the MapView
--- @param dv Vector the displacement Vector.DungeonPokemonPlayer
function MapView:move(dv)
    self.step_vector = dv / self.step_total_frames
    self.step_final_center = self.center + dv
end

--- Returns the position that the MapView is capturing
--- @return Vector the position that the MapView is capturing
function MapView:get_center()
    return self.center
end

--- Sets the new position for the MapView
--- @param pos Vector the new MapView position to capture
function MapView:set_center(center)
    self.center = center
    self.pos.x = center.x - 1 - (love.graphics.getWidth() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
    self.pos.y = center.y - 1 - (love.graphics.getHeight() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
    self:update_batch()
end

--- Updates the visible tiles of the view to adecuate it to the coordinates.
function MapView:update_batch()
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

--- Continues any active movement
function MapView:update()
    if self.step_vector then -- If is moving
        self:move_inmediate(self.step_vector)
        self.step_current_frames = self.step_current_frames + 1
        if self.step_current_frames == self.step_total_frames then
            self.step_current_frames = 0
            self.step_vector = nil
            self:set_center(self.step_final_center)
            self.step_final_pos = nil
        end
    end
end

--- Draws the cells and the Pokemon of the Floor
function MapView:draw()
    love.graphics.draw(
        self.batch,
        mfloor(-(self.pos.x % 1) * globals.CELL_SIZE),
        mfloor(-(self.pos.y % 1) * globals.CELL_SIZE)
    )
    --- @param pokemon DungeonPokemon
    for _, pokemon in ipairs(self.floor.pokemons) do
        pokemon:draw(((pokemon:get_position() - _C.Vector:new(1, 1)) * 24) + self.pos * -24)
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
