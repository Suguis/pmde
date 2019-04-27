local s = _C.GameState:new()

local actions = require "src.modules.actions"

--- @type DungeonPokemonPlayer
local player
--- @type Dungeon
local dungeon = nil
function s.init()
    player = _C.DungeonPokemonPlayer:new(1, 1, _C.Vector:new(1, 1))

    dungeon = _C.Dungeon:new("Test dungeon", 1, 48, 32, "tiny-woods")
    dungeon:get_view():set_center(player:get_position())
    dungeon:get_floor(player:get_current_floor()):add_pokemon(player)
end

function s.update(dt)
    player:update(dt)
    dungeon:get_view():update()
end

function s.draw()
    dungeon.view:draw()
end

function s.keypressed(key, scancode, isrepeat)
    local action = actions.get_action(key)
    local vector = actions.get_move_vector(action)
    if vector then
        dungeon:get_view():move(vector)
        player:move(vector)
    end
end

return s
