--- @class GamestateManager the main manager of the gamestates.
--- It has methods to change the current Gamestate. Love2d callbacks
--- always call the GamestateManager callbacks, and these call the current
--- Gamestate callbacks.
local GamestateManager = _C.Object:new_void()
GamestateManager.__index = GamestateManager

--- Creates a new GamestateManager.
--- @param gamestates table a table of the names of the gamestates to include in the game.
--- @param first_gamestate string the name of the first gamestate to run.
--- @return GamestateManager the new GamestateManager.
function GamestateManager:new(gamestates, first_gamestate)
    local new = setmetatable(_C.Object:new(), self)

    for i = 1, #gamestates do
        gamestates[i] = require("src.gamestates." .. gamestates[i])
    end

    new.gamestates = gamestates
    new.current = gamestates[first_gamestate]

    return new
end

--- Creates a GamestateManager with no atributes, useful for inheritance.
--- @return GamestateManager a new void GamestateManager.
function GamestateManager:new_void()
    return setmetatable(_C.Object:new_void(), self)
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
--- @return Gamestate the current Gamestate
function GamestateManager:getCurrent()
    return self.current
end

--- Sets a Gamestate to be the current Gamestate, and calls it's init method.
--- @param new_current Gamestate the Gamestate to be the current.
function GamestateManager:setCurrent(new_current)
    self.current = new_current
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function GamestateManager:__tostring()
    return string.format("GamestateManager = {current = %s}", self.current:__tostring())
end

return GamestateManager
