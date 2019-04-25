--- A vector with two coordinates
-- @classmod Vector
local Vector = _C.Object:new()
Vector.__index = Vector

--- Creates a Vector.
-- @tparam number x the x component.
-- @tparam number y the y component.
-- @treturn Vector the new Vector object.
function Vector:new(x, y)
  return setmetatable({
    x = x,
    y = y
  }, self)
end

--- Allows to sum vectors with the + operator.
--
-- This metamethod sums the x and the y components of the vectors and returns
-- a new Vector with the result.
-- @tparam Vector vector the vector to add with.
-- @treturn Vector the new Vector object.
function Vector:__add(vector)
  return Vector:new(self.x + vector.x, self.y + vector.y)
end

--- Allows to substract vectors with the - operator.
--
-- This metamethod substracts the x and the y components of the vectors and
-- returns a new Vector with the result.
-- @tparam Vector vector the vector to substract with.
-- @treturn Vector the new Vector object.
function Vector:__sub(vector)
  return Vector:new(self.x - vector.x, self.y - vector.y)
end

--- Allows to multiply a vector with a scalar with the * operator.
--
-- This metamethod returns a new vector multiplying their coordinates with an
-- scalar.
-- @tparam number scalar the scalar to multiply with the vector.
-- @treturn Vector the new Vector object.
function Vector:__mul(scalar)
  return Vector:new(self.x * scalar, self.y * scalar)
end

--- Allows to divide a vector with a scalar with the / operator.
--
-- This metamethod returns a new Vector dividing their coordinates with an
-- scalar.
-- @tparam number scalar the scalar to divide with the vector.
-- @treturn Vector the new Vector object.
function Vector:__div(scalar)
  return Vector:new(self.x / scalar, self.y / scalar)
end

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function Vector:__tostring()
  return string.format("Vector = (%d, %d)", self.x, self.y)
end

--- Checks if the Vector is equal to other
-- @tparam Vector vector the other vector to compare
-- @treturn boolean if the Vectors are equal
function Vector:__eq(vector)
  return self.x == vector.x and self.y == vector.y
end

return Vector
