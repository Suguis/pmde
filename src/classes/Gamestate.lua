--- @class Gamestate a Gamestate is a part of the game that consists in a differentiated
--- part of the game, compared to other gamestates (for example, a main menu
--- Gamestate or a in-dungeon Gamestate). They have their unique callbacks.
--. Gamestates need to be implemented into the gamestates/ folder.
local Gamestate = _C.Object:new_void()
Gamestate.__index = Gamestate

--- Creates a new Gamestate
--- @return Gamestate the new Gamestate
function Gamestate:new()
    local new = setmetatable(_C.Object:new(), self)

    new.id = nil

    return new
end

function Gamestate:new_void()
    return setmetatable(_C.Object:new_void(), self)
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
