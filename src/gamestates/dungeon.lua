local s = _C.GameState:new()

local player
local dungeon
local view

function s.init()
  player = _C.DungeonPokemonPlayer:new(1, 2, _C.Vector:new(1, 1))
  dungeon = _C.Dungeon:new("Test dungeon", 1, 48, 32, "tiny-woods")
  view = _C.MapView:new(player:getPosition(),
      dungeon:getFloor(player:getCurrentFloor()), dungeon:getTileset())

  dungeon:getFloor(player:getCurrentFloor()):addPokemon(player)
  view:updateInstances()

  print(dungeon:getFloor(player:getCurrentFloor()))
end

function s.update(dt)
  player:update(dt)
end

function s.draw()
  view:draw()
end

function s.keypressed(key, scancode, isrepeat)
  local action = globals.actions.getAction(key)
  local vector = globals.actions.getMoveVector(action)
  if vector then
    view:move(vector)
  end
end

return s
