--- @class DungeonPokemonAnimation : Animation an animation that represents graphically an instance of the dungeon
local DungeonPokemonAnimation = _C.Animation:new_void()
DungeonPokemonAnimation.__index = DungeonPokemonAnimation

local inout = require "src.modules.inout"

--- Creates a DungeonPokemonAnimation, .
--- @param number number the Pokemon number.
--- @param type string the type of the animation (idle, move, attack).
--- @param direction string the direction of the animation.
--- Each key must have the duration of its sprite, in frames.
--- @return Animation the new Animation.
function DungeonPokemonAnimation:new(number, type, direction)
    local new =
        setmetatable(
        _C.Animation:new(
            "res/animations/" .. number .. "/" .. type .. "/" .. direction .. ".png",
            inout.read_animation_data("res/animations/" .. number .. "/" .. type .. "/animation.lua")
        ),
        self
    )

    new.offset = -- TODO: careful, this is not correct for big sprites (Gyarados, Zapdos...)
        _C.Vector:new(
        new.texture:getWidth() / #new.sprites / 2 - globals.CELL_SIZE / 2,
        new.texture:getHeight() / 2 - globals.CELL_SIZE / 2
    )

    return new
end

--- Creates an DungeonPokemonAnimation with no atributes, useful for inheritance.
--- @return DungeonPokemonAnimation a new void DungeonPokemonAnimation.
function DungeonPokemonAnimation:new_void()
    return setmetatable(_C.Animation:new_void(), self)
end

--- Draws the current sprite of the DungeonPokemonAnimation.
--- @param pos Vector the position to draw the DungeonPokemonAnimation.
function DungeonPokemonAnimation:draw(pos)
    -- We don't take care of self.mirror_x because a DungeonPokemonAnimation will never use that.
    love.graphics.draw(
        self.texture,
        self.sprites[self.current_sprite].quad,
        pos:get_x() - self.offset:get_x() + (self.mirror_x and self.width or 0),
        pos:get_y() - self.offset:get_y(),
        0,
        self.mirror_x and -1 or 1,
        1
    )
end

function DungeonPokemonAnimation:__tostring()
    return string.format(
        "DungeonPokemonAnimation = {current_sprite = %d/%d, " .. "current_frame = %d/%d}",
        self.current_sprite,
        #self.sprites,
        self.current_frame,
        self.duration
    )
end

return DungeonPokemonAnimation
