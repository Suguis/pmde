--- @class Object the class from which all the others inherit.
local Object = {}
Object.__index = Object

function Object:new()
    return setmetatable({}, self)
end

--- Checks if `self` and `other` objects have same types,
--- or share inherited types.
--- @param object Object the object to compare
--- @return boolean if the objects have same type
function Object:is_type_of(object)
    local compared = self.__index
    local comparator = object.__index
    repeat
        if (compared == comparator) then
            return true
        end
        compared = getmetatable(compared)
    until (compared == Object)

    return false
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Object.__tostring()
    return "Object"
end

return Object
