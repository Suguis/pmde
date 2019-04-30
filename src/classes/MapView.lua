--- @class MapView a MapView that shows a specific view of a Floor
local MapView = _C.Object:new_void()
MapView.__index = MapView

local mfloor = math.floor

-- Static atributes
MapView.move_total_time = 12 / 60 -- 24 / 60 if normal speed

--- Creates a new MapView.
--- @param center Vector the Vector of the coordinates that the MapView is going to put in the center.
--- @param floor Floor the Floor on which the MapView is going to focus.
--- @param tileset Image the Image that the MapView buffer is going to use.
--- @return MapView the new MapView.
function MapView:new(center, floor, tileset)
    local new = setmetatable(_C.Object:new(), self)

    self.batch = love.graphics.newSpriteBatch(tileset, 512, "static") -- TODO: this needs to be static

    new.center = center -- The grid cell that the view is centering
    new.position =
        _C.Vector:new( -- The position of the left-up corner
        center.x - 1 - (love.graphics.getWidth() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE),
        center.y - 1 - (love.graphics.getHeight() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
    )
    new.floor = floor
    new.move_current_time = 0 -- The time passed since the beggining of the move.
    new.move_vector = nil -- Vector that the player moves each frame. Depends on the delta time
    new.move_final_center = nil -- Vector that will equals DungeonPokemon pos when it finishes the move

    new:update_batch()

    return new
end

function MapView:new_void()
    return setmetatable(_C.Object:new_void(), self)
end

--- Moves the view inmediately (not use outside the class)
--- @param dv Vector the displacement Vector.
function MapView:move_inmediate(dv)
    local old_pos = self.position

    self.position = self.position + dv
    self.center = self.center + dv / globals.CELL_SIZE

    -- Only update if we move one tile
    if self.position ~= old_pos then
        self:update_batch()
    end
end

--- Begins the move of the MapView
--- @param dv Vector the displacement Vector.DungeonPokemonPlayer
function MapView:move(dv)
    self.move_final_center = self.center + dv
    self.move_vector = dv
end

function MapView:is_moving()
    if self.move_vector then
        return true
    else
        return false
    end
end

--- Returns the position that the MapView is capturing
--- @return Vector the position that the MapView is capturing
function MapView:get_center()
    return self.center
end

--- Sets the new position for the MapView
--- @param center Vector the new MapView position to capture
function MapView:set_center(center)
    self.center = center
    self.position.x = center.x - 1 - (love.graphics.getWidth() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
    self.position.y = center.y - 1 - (love.graphics.getHeight() / 2 - globals.CELL_SIZE / 2) / (globals.CELL_SIZE)
    self:update_batch()
end

--- Updates the visible tiles of the view to adecuate it to the coordinates.
function MapView:update_batch()
    self.batch:clear()
    for x = 1, globals.TILES_DISPLAY_WIDTH do
        for y = 1, globals.TILES_DISPLAY_HEIGHT do
            self.batch:add(
                self.floor:get_cell(x + mfloor(self.position.x), y + mfloor(self.position.y)):get_quad(),
                (x - 1) * globals.CELL_SIZE,
                (y - 1) * globals.CELL_SIZE
            )
        end
    end
    self.batch:flush()
end

--- Continues any active movement
function MapView:update(dt)
    if self:is_moving() then -- If is moving
        self:move_inmediate(self.move_vector * dt / self.move_total_time)
        self.move_current_time = self.move_current_time + dt
        if self.move_current_time >= self.move_total_time then
            self.move_current_time = 0
            self.move_vector = nil
            self:set_center(self.move_final_center)
            self.step_final_center = nil
        end
    end
end

--- Draws the cells and the Pokemon of the Floor
function MapView:draw()
    love.graphics.draw(
        self.batch,
        mfloor(-(self.position.x % 1) * globals.CELL_SIZE),
        mfloor(-(self.position.y % 1) * globals.CELL_SIZE)
    )
    --- @param pokemon DungeonPokemon
    for _, pokemon in ipairs(self.floor.pokemons) do
        pokemon:draw(((pokemon:get_position() - _C.Vector:new(1, 1)) * 24) + self.position * -24)
    end
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function MapView:__tostring()
    return string.format(
        "MapView = {position = %s, width = %d, height = %d}",
        self.position.__tostring(),
        #self.grid,
        #self.grid[1]
    )
end

return MapView
