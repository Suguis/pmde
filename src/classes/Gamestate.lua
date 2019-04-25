local Gamestate = _C.Object:new()
Gamestate.__index = Gamestate

function Gamestate:new()
  return setmetatable({id = nil}, self)
end

function Gamestate.init()
end

function Gamestate.update()
end

function Gamestate.draw()
  love.graphics.print("No draw!", 0, 0)
end

function Gamestate.keypressed()
end

function Gamestate.keyreleased()
end


function Gamestate:__tostring()
  return string.format("Gamestate = {id = %s}", self.id)
end

return Gamestate
