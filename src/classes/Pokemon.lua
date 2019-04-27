--- @class Pokemon a Pokemon, that consists in a Pokemon with it's PokeDex number, level,
-- species, moves... This is an abstract class, it has no `new` method.
local Pokemon = _C.Object:new()
Pokemon.__index = Pokemon

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Pokemon:__tostring()
    return string.format("Pokemon = {number = %d, level = %d}", self.number, self.level)
end

return Pokemon
