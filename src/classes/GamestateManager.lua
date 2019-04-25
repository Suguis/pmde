local GamestateManager = _C.Object:new()
GamestateManager.__index = GamestateManager

function GamestateManager:new(gamestates, defaultGamestate)
  for i = 1, #gamestates do
    gamestates[i] = require ("src.gamestates." .. gamestates[i])
  end

  return setmetatable({
    gamestates = gamestates,
    current = gamestates[defaultGamestate]
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

function GamestateManager:getCurrent()
  return self.current
end

function GamestateManager:setCurrent(newCurrent)
  self.current = newCurrent
end

function GamestateManager:__tostring()
  return string.format("GamestateManager = {current = %s}",
      self.current:__tostring())
end

return GamestateManager
