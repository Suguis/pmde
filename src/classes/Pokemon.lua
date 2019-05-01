--- @class Pokemon a Pokemon, that consists in a Pokemon with it's PokeDex number, level,
-- species, moves... This is an abstract class.
local Pokemon = _C.Object:new_void()
Pokemon.__index = Pokemon

function Pokemon:new(number, level)
    local new = setmetatable(_C.Object:new(), self)

    new.number = number
    new.level = level

    return new
end

--- Creates a Pokemon with no atributes, useful for inheritance.
--- @return Pokemon a new void Pokemon.
function Pokemon:new_void()
    return setmetatable(_C.Object:new_void(), self)
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Pokemon:__tostring()
    return string.format("Pokemon = {number = %d, level = %d}", self.number, self.level)
end

return Pokemon
