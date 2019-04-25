--- A class that represents a Pokémon into a dungeon.
-- @classmod DungeonPokemon

local DungeonPokemon = _C.Pokemon:new()
DungeonPokemon.__index = DungeonPokemon

--- Creates a new DungeonPokemonPlayer.
-- @tparam number number the PokéDex number of the Pokémon.
-- @tparam number level the level.
-- @tparam Vector position the Vector that represents the position.
function DungeonPokemon:new(number, level, position)
  return setmetatable({
    -- animation = animation,
    number = number,
    level = level,
    position = position,
    drawPosition = position and _C.Vector:new(position:get_x(), position:get_y()) or nil
  }, self)
end

function DungeonPokemon:get_position()
  return self.position
end

function DungeonPokemon:move(moveVector)
  self.position = self.position + moveVector
end

--- Updates the animation
function DungeonPokemon:update()
  self.animation:update()
end

--- Sets the Pokémon draw position
function DungeonPokemon:move_draw_pos(pos)
  self.draw_position = self.position + pos
end

--- Draws the Pokémon
function DungeonPokemon:draw()
  self.animation:draw(self.draw_position)
end

function DungeonPokemon:__tostring()
  return string.format(
      "DungeonPokemon = {number = %d, level = %d, position = (%d, %d)}",
      self.number, self.level, self.position:get_x(), self.position:get_y())
end

return DungeonPokemon
