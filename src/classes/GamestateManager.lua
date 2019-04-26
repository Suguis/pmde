--- The main manager of the gamestates. It has methods to change the current Gamestate.
-- Love2d callbacks always call the GamestateManager callbacks, and these call the current
-- Gamestate callbacks.
-- @classmod GamestateManager
local GamestateManager = _C.Object:new()
GamestateManager.__index = GamestateManager

--- Creates a new GamestateManager.
-- @tparam table gamestates a table of the names of the gamestates to include in the game.
-- @tparam string first_gamestate the name of the first gamestate to run.
-- @treturn GamestateManager the new GamestateManager.
function GamestateManager:new(gamestates, first_gamestate)
  for i = 1, #gamestates do
    gamestates[i] = require ("src.gamestates." .. gamestates[i])
  end

  return setmetatable({
    gamestates = gamestates,
    current = gamestates[first_gamestate]
  }, self)
end

function GamestateManager:init()
  self.current.init()
end

function GamestateManager:update(dt)
  self.current.update(dt)
end

function GamestateManager:draw()
  self.current.draw()
end

function GamestateManager:keypressed(key, scancode, isrepeat)
  self.current.keypressed(key, scancode, isrepeat)
end

function GamestateManager:keyreleased(key)
  self.current.keyreleased(key)
end

--- Gets the current Gamestate
-- @treturn Gamestate the current Gamestate
function GamestateManager:getCurrent()
  return self.current
end

--- Sets a Gamestate to be the current Gamestate, and calls it's init method.
-- @tparam Gamestate new_current the Gamestate to be the current.
function GamestateManager:setCurrent(new_current)
  self.current = new_current
end

--- Converts the object into a string with its information.
-- @treturn string a string with the object information.
function GamestateManager:__tostring()
  return string.format("GamestateManager = {current = %s}",
      self.current:__tostring())
end

return GamestateManager
