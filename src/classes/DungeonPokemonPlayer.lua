---@class DungeonPokemonPlayer : DungeonPokemon a class that represents a player into a Dungeon.
local DungeonPokemonPlayer = _C.DungeonPokemon:new()
DungeonPokemonPlayer.__index = DungeonPokemonPlayer

--- Creates a new DungeonPokemonPlayer.
--- @param number number the PokéDex number of the Pokémon.
--- @param level number the level.
--- @param position Vector the Vector that represents the position.
--- @param current_floor number the Floor on which the player is.
function DungeonPokemonPlayer:new(number, level, position, current_floor) -- TODO: Add a MapView parameter to the player
    local sprite_frame_data = {
        [1] = 38,
        [2] = 9,
        [3] = 9
    }

    return setmetatable(
        {
            number = number,
            level = level,
            position = position,
            current_floor = current_floor or 1,
            draw_position = _C.Vector:new(position:get_x(), position:get_y()),
            animation = _C.Animation:new("res/animations/258/idle/down.png", 32, 32, sprite_frame_data)
        },
        self
    )
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
        self.position:get_x(),
        self.position:get_y()
    )
end

return DungeonPokemonPlayer
