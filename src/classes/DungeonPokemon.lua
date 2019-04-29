--- @class DungeonPokemon : Pokemon represents a Pokémon into a dungeon.
local DungeonPokemon = _C.Pokemon:new()
DungeonPokemon.__index = DungeonPokemon

-- Static atributes
DungeonPokemon.move_total_time = 12 / 60 -- the time that requires the move to be executed

--- Creates a new DungeonPokemonPlayer.
--- @param number number the PokéDex number of the Pokémon.
--- @param level number the level.
--- @param position Vector the Vector that represents the position.
function DungeonPokemon:new(number, level, position)
    local new = setmetatable(_C.Pokemon:new(number, level), self)

    new.position = position
    new.move_current_time = 0 -- The time passed since the beggining of the move.
    new.move_vector = nil -- Vector that the player moves each frame. Depends on the delta time
    new.move_final_pos = position -- Vector that will equals DungeonPokemon pos when it finishes the move

    return new
end

--- Gets the position of the DungeonPokemon.
--- @return Vector the position of the DungeonPokemon.
function DungeonPokemon:get_position()
    return self.position
end

--- Begins the move of the DungeonPokemon
--- @param move_vector Vector the displacement Vector.
function DungeonPokemon:move(dv)
    self.move_final_pos = self.position + dv
    self.move_vector = dv
end

function DungeonPokemon:is_moving()
    if self.move_vector then
        return true
    else
        return false
    end
end
--- Updates the animation and continues any active movement.
function DungeonPokemon:update(dt)
    if self:is_moving() then -- If is moving
        self.position = self.position + self.move_vector * dt / self.move_total_time
        self.move_current_time = self.move_current_time + dt
        if self.move_current_time >= self.move_total_time then
            self.move_current_time = 0
            self.move_vector = nil
            self.position = self.move_final_pos
        end
    end
    self.animation:update(dt)
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
        self.move_final_pos:get_x(),
        self.move_final_pos:get_y()
    )
end

return DungeonPokemon
