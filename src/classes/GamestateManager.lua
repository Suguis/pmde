local GamestateManager = _C.Object:new()
GamestateManager.__index = GamestateManager

function GamestateManager:new(gamestates, default_gamestate)
  for i = 1, #gamestates do
    gamestates[i] = require ("src.gamestates." .. gamestates[i])
  end

  return setmetatable({
    gamestates = gamestates,
    current = gamestates[default_gamestate]
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

function GamestateManager:setCurrent(new_current)
  self.current = new_current
end

function GamestateManager:__tostring()
  return string.format("GamestateManager = {current = %s}",
      self.current:__tostring())
end

return GamestateManager
