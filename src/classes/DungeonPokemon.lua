--- @class DungeonPokemon : Pokemon represents a Pokémon into a dungeon.
local DungeonPokemon = _C.Pokemon:new()
DungeonPokemon.__index = DungeonPokemon

--- Creates a new DungeonPokemonPlayer.
--- @param number number the PokéDex number of the Pokémon.
--- @param level number the level.
--- @param position Vector the Vector that represents the position.
function DungeonPokemon:new(number, level, position)
    return setmetatable(
        {
            -- animation = animation,
            number = number,
            level = level,
            position = position,
            step_current_frames = 0,
            step_total_frames = 12, -- 24 if normal speed
            step_vector = nil, -- Vector that the player moves each step
            step_final_pos = nil -- Vector that will equals DungeonPokemon pos when it finishes the move
        },
        self
    )
end

--- Gets the position of the DungeonPokemon.
--- @return Vector the position of the DungeonPokemon.
function DungeonPokemon:get_position()
    return self.position
end

--- Begins the move of the DungeonPokemon
--- @param move_vector Vector the displacement Vector.
function DungeonPokemon:move(dv)
    self.step_vector = dv / self.step_total_frames
    self.step_final_pos = self.position + dv
end

--- Updates the animation and continues any active movement.
function DungeonPokemon:update()
    self.animation:update()
    if self.step_vector then -- If is moving
        self.position = self.position + self.step_vector
        self.step_current_frames = self.step_current_frames + 1
        if self.step_current_frames == self.step_total_frames then
            self.step_current_frames = 0
            self.step_vector = nil
            self.position = self.step_final_pos
            self.step_final_pos = nil
        end
    end
end

--- Draws the Pokémon.
function DungeonPokemon:draw(pos)
    self.animation:draw(pos)
end

--- Converts the DungeonPokemonPlayer into a string with its information.
--- @return string a string with the object information.
function DungeonPokemon:__tostring()
    return string.format(
        "DungeonPokemon = {number = %d, level = %d, position = (%d, %d)}",
        self.number,
        self.level,
        self.position:get_x(),
        self.position:get_y()
    )
end

return DungeonPokemon
