--- A Pokémon, that consists in a Pokémon with it's PokéDex number, level,
-- species, moves... This is an abstract class, it has no `new` method.
-- @classmod Pokemon
local Pokemon = _C.Object:new()
Pokemon.__index = Pokemon

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function Pokemon:__tostring()
  return string.format("Pokemon = {number = %d, level = %d}", self.number, self.level)
end

return Pokemon
