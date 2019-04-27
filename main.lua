globals = require "src.globals"
require "src.classes" -- Puts all classes in global _C table

local lovebird = require("lib.lovebird")
io.stdout:setvbuf("no")

local manager =
    _C.GamestateManager:new(
    {
        "dungeon"
    },
    1
)

function love.load()
    math.randomseed(os.time())
    math.random()
    manager:getCurrent():init()
end

function love.update(dt)
    lovebird.update()
    globals.time = globals.time + dt
    globals.frames = globals.frames + 1
    manager:update(dt)
end

function love.draw()
    manager:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "d" and love.keyboard.isDown("lctrl") then
        debug.debug()
    end
    manager:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key)
    manager:keyreleased(key)
end

function love.quit()
end
