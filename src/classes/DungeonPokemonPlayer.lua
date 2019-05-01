--- @class DungeonPokemonPlayer : DungeonPokemon a class that represents a player into a Dungeon.
local DungeonPokemonPlayer = _C.DungeonPokemon:new_void()
DungeonPokemonPlayer.__index = DungeonPokemonPlayer

--- Creates a new DungeonPokemonPlayer.
--- @param number number the PokéDex number of the Pokémon.
--- @param level number the level.
--- @param position Vector the Vector that represents the position.
--- @param current_floor number the Floor on which the player is.
function DungeonPokemonPlayer:new(number, level, position, current_floor)
    local new = setmetatable(_C.DungeonPokemon:new(number, level, position), self)

    new.current_floor = current_floor or 1
    new.draw_position = _C.Vector:new(position:get_x(), position:get_y())

    return new
end

--- Creates an DungeonPokemonPlayer with no atributes, useful for inheritance.
--- @return DungeonPokemonPlayer a new void DungeonPokemonPlayer.
function DungeonPokemonPlayer:new_void()
    return setmetatable(_C.DungeonPokemon:new_void(), self)
end

--- Returns the floor on which the player is.
--- @return number the floor on which the player is.
function DungeonPokemonPlayer:get_current_floor()
    return self.current_floor
end

--- Converts the DungeonPokemonPlayer into a string with its information.
--- @return string a string with the object information.
function DungeonPokemonPlayer:__tostring()
    return string.format(
        "DungeonPokemonPlayer = {number = %d, level = %d, position = (%d, %d)}",
        self.number,
        self.level,
        self.move_final_pos:get_x(),
        self.move_final_pos:get_y()
    )
end

return DungeonPokemonPlayer
