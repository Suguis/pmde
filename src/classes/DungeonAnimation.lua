--- @class DungeonAnimation : Animation an animation that represents graphically an instance of the dungeon
local DungeonAnimation = _C.Animation:new_void()
DungeonAnimation.__index = DungeonAnimation

--- Creates a DungeonAnimation, .
--- @param path string the patch to the spritesheet.
--- @param frames_duration table<number, table<Quad, number>> a table with keys from 1 to the number of sprites.
--- Each key must have the duration of its sprite, in frames.
--- @return Animation the new Animation.
function DungeonAnimation:new(path, sprite_frame_data)
    local new = setmetatable(_C.Animation:new(path, sprite_frame_data), self)

    new.offset = -- TODO: careful, this is not correct for big sprites (Gyarados, Zapdos...)
        _C.Vector:new(
        new.texture:getWidth() / #new.sprites / 2 - globals.CELL_SIZE / 2,
        new.texture:getHeight() / 2 - globals.CELL_SIZE / 2
    )

    return new
end

--- Creates an DungeonAnimation with no atributes, useful for inheritance.
--- @return DungeonAnimation a new void DungeonAnimation.
function DungeonAnimation:new_void()
    return setmetatable(_C.Animation:new_void(), self)
end

--- Draws the current sprite of the DungeonAnimation.
--- @param pos Vector the position to draw the DungeonAnimation.
function DungeonAnimation:draw(pos)
    -- We don't take care of self.mirror_x because a DungeonAnimation will never use that.
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

function DungeonAnimation:__tostring()
    return string.format(
        "DungeonAnimation = {current_sprite = %d/%d, " .. "current_frame = %d/%d}",
        self.current_sprite,
        #self.sprites,
        self.current_frame,
        self.duration
    )
end

return DungeonAnimation
