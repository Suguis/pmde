local s = _C.GameState:new()

local actions = require "src.modules.actions"

--- @type DungeonPokemonPlayer
local player
--- @type Dungeon
local dungeon = nil

--- Controls the move of a DungeonPokemon when a key is pressed.
--- @param pokemon DungeonPokemon the Pokemon to move.
--- @param vector Vector the displacement vector.
local function control_move(pokemon, vector)
    -- We use player to control the floor because the game will always be in the player floor
    if dungeon:get_floor(player:get_current_floor()):get_cell(pokemon:get_position() + vector):get_type() == 2 then
        if not pokemon:is_moving() then
            pokemon:move(vector)
        end

        if not dungeon:get_view():is_moving() then
            dungeon:get_view():move(vector)
        end
    end
end

function s.init()
    player = _C.DungeonPokemonPlayer:new(258, 1, _C.Vector:new(1, 1))

    dungeon = _C.Dungeon:new("Test dungeon", 1, 48, 32, "tiny-woods")
    dungeon:get_view():set_center(player:get_position())
    dungeon:get_floor(player:get_current_floor()):add_pokemon(player)
end

function s.update(dt)
    player:update(dt)
    dungeon:get_view():update(dt)
end

function s.draw()
    dungeon.view:draw()
end

function s.keypressed(key, scancode, isrepeat)
    local action = actions.get_action(key)
    local vector = actions.get_move_vector(action)
    if vector then
        control_move(player, vector)
    end
end

return s
