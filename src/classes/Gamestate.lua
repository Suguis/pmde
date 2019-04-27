--- @class Gamestate a Gamestate is a part of the game that consists in a differentiated
--- part of the game, compared to other gamestates (for example, a main menu
--- Gamestate or a in-dungeon Gamestate). They have their unique callbacks.
--. Gamestates need to be implemented into the gamestates/ folder.
local Gamestate = _C.Object:new()
Gamestate.__index = Gamestate

--- Creates a new Gamestate
--- @return Gamestate the new Gamestate
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

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Gamestate:__tostring()
    return string.format("Gamestate = {id = %s}", self.id)
end

return Gamestate
