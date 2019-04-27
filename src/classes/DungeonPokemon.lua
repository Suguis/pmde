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
            draw_position = position and _C.Vector:new(position:get_x(), position:get_y()) or nil
        },
        self
    )
end

--- Gets the position of the DungeonPokemon.
--- @return Vector the position of the DungeonPokemon.
function DungeonPokemon:get_position()
    return self.position
end

--- Moves the DungeonPokemon
--- @param move_vector Vector the displacement Vector.
function DungeonPokemon:move(move_vector)
    self.position = self.position + move_vector
end

--- Updates the animation.
function DungeonPokemon:update()
    self.animation:update()
end

--- Sets the Pokémon draw position.
function DungeonPokemon:move_draw_pos(pos)
    self.draw_position = self.position + pos
end

--- Draws the Pokémon.
function DungeonPokemon:draw()
    self.animation:draw(self.draw_position)
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
