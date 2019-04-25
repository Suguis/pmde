local Object = {}
Object.__index = Object

function Object:new()
  return setmetatable({}, self)
end

function Object:isTypeOf(object)
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

function Object.__tostring()
  return "Object"
end

return Object
