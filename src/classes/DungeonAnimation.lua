--- @class DungeonAnimation : Animation an animation that represents graphically an instance of the dungeon
local DungeonAnimation = _C.Animation:new_void()
DungeonAnimation.__index = DungeonAnimation

--- Creates a DungeonAnimation, .
--- @param path string the patch to the spritesheet.
--- @param number width the width of the sprite.
--- @param height number the height of the sprite.
--- @param frames_duration table<number, table<Quad, number>> a table with keys from 1 to the number of sprites.
--- Each key must have the duration of its sprite, in frames.
--- @return Animation the new Animation.
function DungeonAnimation:new(path, width, height, sprite_frame_data)
    local new = setmetatable(_C.Animation:new(path, width, height, sprite_frame_data), self)

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
    love.graphics.draw(
        self.texture,
        self.sprites[self.current_sprite].quad,
        pos:get_x() - self.offset:get_x(),
        pos:get_y() - self.offset:get_y()
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
