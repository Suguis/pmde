---@class DungeonPokemonPlayer : DungeonPokemon a class that represents a player into a Dungeon.
local DungeonPokemonPlayer = _C.DungeonPokemon:new_void()
DungeonPokemonPlayer.__index = DungeonPokemonPlayer

local inout = require "src.modules.inout"

--- Creates a new DungeonPokemonPlayer.
--- @param number number the PokéDex number of the Pokémon.
--- @param level number the level.
--- @param position Vector the Vector that represents the position.
--- @param current_floor number the Floor on which the player is.
function DungeonPokemonPlayer:new(number, level, position, current_floor)
    local new = setmetatable(_C.DungeonPokemon:new(number, level, position), self)

    local animation_data = inout.read_animation("res/animations/" .. number .. "/idle/animation.lua")

    local sprite_frame_data = animation_data

    new.number = number
    new.level = level
    new.position = position
    new.current_floor = current_floor or 1
    new.draw_position = _C.Vector:new(position:get_x(), position:get_y())
    new.animation = _C.DungeonAnimation:new("res/animations/" .. number .. "/idle/down.png", 32, 32, sprite_frame_data) -- TODO: Mover el parametro animation a DungeonPokemon, y hacer que se cargue el sprite indicado según el número, igual con el sprite_frame_data, que se cargue desde un archivo automáticamente.

    return new
end

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
