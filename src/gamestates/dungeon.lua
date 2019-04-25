local s = _C.GameState:new()

local player
local dungeon
local view

function s.init()
  player = _C.DungeonPokemonPlayer:new(1, 2, _C.Vector:new(1, 1))
  dungeon = _C.Dungeon:new("Test dungeon", 1, 48, 32, "tiny-woods")
  view = _C.MapView:new(player:get_position(),
      dungeon:get_floor(player:get_current_floor()), dungeon:get_tileset())

  dungeon:get_floor(player:get_current_floor()):add_pokemon(player)
  view:update_instances()

  print(dungeon:get_floor(player:get_current_floor()))
end

function s.update(dt)
  player:update(dt)
end

function s.draw()
  view:draw()
end

function s.keypressed(key, scancode, isrepeat)
  local action = globals.actions.get_action(key)
  local vector = globals.actions.get_move_vector(action)
  if vector then
    view:move(vector)
  end
end

return s
