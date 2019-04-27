local s = _C.GameState:new()

local actions = require "src.modules.actions"

local player
--- @type Dungeon
local dungeon = nil
function s.init()
    player = _C.DungeonPokemonPlayer:new(1, 2, _C.Vector:new(1, 1))

    dungeon = _C.Dungeon:new("Test dungeon", 1, 48, 32, "tiny-woods")
    dungeon:get_view():set_position(player:get_position())
    dungeon:get_floor(player:get_current_floor()):add_pokemon(player)
    dungeon:get_view():update_instances()
    print(dungeon:get_view():get_position())
end

function s.update(dt)
    player:update(dt)
end

function s.draw()
    dungeon.view:draw()
end

function s.keypressed(key, scancode, isrepeat)
    local action = actions.get_action(key)
    local vector = actions.get_move_vector(action)
    if vector then
        dungeon:get_view():move(vector)
        print(dungeon:get_view():get_position())
    end
end

return s
