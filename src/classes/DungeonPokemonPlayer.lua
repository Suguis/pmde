--- A class that represents a player into a dungeon.
-- Derived from `DungeonPokemon`.
-- @classmod DungeonPokemonPlayer
local DungeonPokemonPlayer = _C.DungeonPokemon:new()
DungeonPokemonPlayer.__index = DungeonPokemonPlayer

--- Creates a new DungeonPokemonPlayer.
-- @tparam number number the PokéDex number of the Pokémon.
-- @tparam number level the level.
-- @tparam Vector position the Vector that represents the position.
-- @tparam[opt=1] number currentFloor the floor on which the player is.
function DungeonPokemonPlayer:new(number, level, position, currentFloor)
  local spriteFrameData = {
    [1] = 38,
    [2] = 9,
    [3] = 9
  }

  return setmetatable({
    animation = _C.Animation:new(
        "res/animations/258/idle/down.png",
        32, 32, spriteFrameData),
    number = number,
    level = level,
    position = position,
    drawPosition = _C.Vector:new(position.x, position.y),
    currentFloor = currentFloor or 1
  }, self)
end

--- Returns the floor on which the player is.
-- @treturn number the floor on which the player is.
function DungeonPokemonPlayer:getCurrentFloor()
  return self.currentFloor
end

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function DungeonPokemonPlayer:__tostring()
  return string.format(
      "DungeonPokemonPlayer = {number = %d, level = %d, position = (%d, %d)}",
      self.number, self.level, self.position.x, self.position.y)
end

return DungeonPokemonPlayer
