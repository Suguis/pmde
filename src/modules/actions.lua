--- Module that contains associations between inputs and actions.
-- An action is a definition to a key press. One action can be associated to a
-- multiple keys, and these can be changed easily, without change the entire code.
-- @module actions
local keys = {}

--- A table representing the KeyConstants assigned to the different actions.
keys.actions = {
  up = "up",  -- KeyConstant assigned to up action.
  down = "down",  -- KeyConstant assigned to down action.
  left = "left",  -- KeyConstant assigned to left action.
  right = "right"  -- KeyConstant assigned to right action.
}

--- Gets an action from a key and returns it.
-- @tparam string key the key from which calculate the action.
-- @treturn string the action associated to that key.
function keys.get_action(key)
  for k, v in pairs(keys.actions) do
    if key == v then return k end
  end
end

--- Returns a Vector from a movement action.
-- @tparam string moveAction the action that represents a direction.
-- @treturn Vector the unit Vector of the direction, or nil if the action is not
-- a move action.
function keys.get_move_vector(moveAction)
  if moveAction == keys.actions.up then
    return _C.Vector:new(0, -1)
  elseif moveAction == keys.actions.down then
    return _C.Vector:new(0, 1)
  elseif moveAction == keys.actions.left then
    return _C.Vector:new(-1, 0)
  elseif moveAction == keys.actions.right then
    return _C.Vector:new(1, 0)
  end
end

return keys
