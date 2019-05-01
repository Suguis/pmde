--- @class DungeonPokemon : Pokemon represents a Pokémon into a dungeon.
local DungeonPokemon = _C.Pokemon:new_void()
DungeonPokemon.__index = DungeonPokemon

local inout = require "src.modules.inout"

-- Static atributes
DungeonPokemon.move_total_time = 12 / 60 -- the time that requires the move to be executed (12 frames when 60FPS)

--- Creates a new DungeonPokemonPlayer.
--- @param number number the PokéDex number of the Pokémon.
--- @param level number the level.
--- @param position Vector the Vector that represents the position.
function DungeonPokemon:new(number, level, position)
    local new = setmetatable(_C.Pokemon:new(number, level), self)

    local sprite_frame_data = inout.read_animation_data("res/animations/" .. number .. "/idle/animation.lua")

    new.position = position
    new.view_direction = _C.Vector:new(0, 1) -- Default view direction, the player will be looking down
    new.move_current_time = 0 -- The time passed since the beggining of the move.
    new.move_vector = nil -- Vector that the player moves each frame. Depends on the delta time
    new.move_final_pos = position -- Vector that will equals DungeonPokemon pos when it finishes the move

    new.animations = {
        -- TODO: Hacer una clase DungeonPokemonAnimation (o algo así, o incluso eliminar DungeonAnimation y usar esta) que a partir del número cargue ya las animaciones correspondientes
        up = _C.DungeonAnimation:new("res/animations/" .. number .. "/idle/up.png", sprite_frame_data),
        down = _C.DungeonAnimation:new("res/animations/" .. number .. "/idle/down.png", sprite_frame_data),
        lr = _C.DungeonAnimation:new("res/animations/" .. number .. "/idle/lr.png", sprite_frame_data)
    }
    new.current_animation = new.animations.down

    return new
end

--- Creates an DungeonPokemon with no atributes, useful for inheritance.
--- @return DungeonPokemon a new void DungeonPokemon.
function DungeonPokemon:new_void()
    return setmetatable(_C.Pokemon:new_void(), self)
end

--- Gets the position of the DungeonPokemon.
--- @return Vector the position of the DungeonPokemon.
function DungeonPokemon:get_position()
    return self.position
end

--- Sets the view direction (where the player is looking), and also sets the proper Animation.
--- @param view_direction Vector the view direction.
function DungeonPokemon:set_view_direction(view_direction)
    self.view_direction = view_direction
    self:set_proper_animation()
end

--- Sets the proper animation according to the view direction.
function DungeonPokemon:set_proper_animation()
    local x, y = self.view_direction:get_coordinates()
    local proper_animation = self.current_animation
    local mirror = self.current_animation:get_mirror_x()

    if x == -1 then
        mirror = false
        if y == -1 then
        elseif y == 0 then
            proper_animation = self.animations.lr
        elseif y == 1 then
        end
    elseif x == 0 then
        mirror = false
        if y == -1 then
            proper_animation = self.animations.up
        elseif y == 0 then
        elseif y == 1 then
            proper_animation = self.animations.down
        end
    elseif x == 1 then
        mirror = true
        if y == -1 then
        elseif y == 0 then
            proper_animation = self.animations.lr
        elseif y == 1 then
        end
    end

    if proper_animation ~= self.current_animation then
        self.current_animation = proper_animation
        self.current_animation:reset()
    end

    if mirror ~= self.current_animation:get_mirror_x() then
        self.current_animation:set_mirror_x(mirror)
        self.current_animation:reset()
    end
end

--- Begins the move of the DungeonPokemon
--- @param move_vector Vector the displacement Vector.
function DungeonPokemon:move(dv)
    self.move_final_pos = self.position + dv
    self.move_vector = dv
end

function DungeonPokemon:is_moving()
    if self.move_vector then
        return true
    else
        return false
    end
end
--- Updates the animation and continues any active movement.
function DungeonPokemon:update(dt)
    if self:is_moving() then -- If is moving
        self.position = self.position + self.move_vector * dt / self.move_total_time
        self.move_current_time = self.move_current_time + dt
        if self.move_current_time >= self.move_total_time then
            self.move_current_time = 0
            self.move_vector = nil
            self.position = self.move_final_pos
        end
    end
    self.current_animation:update(dt)
end

--- Draws the Pokémon.
function DungeonPokemon:draw(pos)
    self.current_animation:draw(pos, false, false)
end

--- Converts the DungeonPokemonPlayer into a string with its information.
--- @return string a string with the object information.
function DungeonPokemon:__tostring()
    return string.format(
        "DungeonPokemon = {number = %d, level = %d, position = (%d, %d)}",
        self.number,
        self.level,
        self.move_final_pos:get_x(),
        self.move_final_pos:get_y()
    )
end

return DungeonPokemon
