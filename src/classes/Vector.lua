--- @class Vector a Vector with two coordinates
local Vector = _C.Object:new()
Vector.__index = Vector

--- Creates a Vector.
--- @param x number the x component.
--- @param y number the y component.
--- @return Vector the new Vector object.
function Vector:new(x, y)
    local new = setmetatable(_C.Object:new(), self)

    new.x = x
    new.y = y

    return new
end

--- Returns the x coordinate of the Vector
--- @return number the x coordinate of the Vector
function Vector:get_x()
    return self.x
end

--- Changes the x coordinate of the Vector
--- @param x number the new x coordinate of the Vector
function Vector:set_x(x)
    self.x = x
end

--- Returns the y coordinate of the Vector
--- @return number the y coordinate of the Vector
function Vector:get_y()
    return self.y
end

--- Changes the y coordinate of the Vector
--- @param y number the new y coordinate of the Vector
function Vector:set_y(y)
    self.y = y
end

--- Allows to sum vectors with the + operator.
--- This metamethod sums the x and the y components of the Vectors and returns
--- a new Vector with the result.
--- @param vector Vector the Vector to add with.
--- @return Vector the new Vector object.
function Vector:__add(vector)
    return Vector:new(self.x + vector.x, self.y + vector.y)
end

--- Allows to substract vectors with the - operator.
--- This metamethod substracts the x and the y components of the Vectors and
--- returns a new Vector with the result.
--- @param vector Vector the Vector to substract with.
--- @return Vector the new Vector object.
function Vector:__sub(vector)
    return Vector:new(self.x - vector.x, self.y - vector.y)
end

--- Allows to multiply a Vector with a scalar with the * operator.
--- This metamethod returns a new Vector multiplying their coordinates with an
--- scalar.
--- @param scalar number the scalar to multiply with the Vector.
--- @return Vector the new Vector object.
function Vector:__mul(scalar)
    return Vector:new(self.x * scalar, self.y * scalar)
end

--- Allows to divide a Vector with a scalar with the / operator.
--- This metamethod returns a new Vector dividing their coordinates with an
--- scalar.
--- @param scalar number the scalar to divide with the Vector.
--- @return Vector the new Vector object.
function Vector:__div(scalar)
    return Vector:new(self.x / scalar, self.y / scalar)
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Vector:__tostring()
    return string.format("Vector = (%f, %f)", self.x, self.y)
end

--- Checks if the Vector is equal to other
--- @param vector Vector the other Vector to compare
--- @return boolean if the Vectors are equal
function Vector:__eq(vector)
    return self.x == vector.x and self.y == vector.y
end

return Vector
