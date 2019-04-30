--- @class Animation : DungeonPokemonPlayer
local Animation = _C.Object:new()
Animation.__index = Animation

--- Creates an Animation.
--- @param path string the patch to the spritesheet.
--- @param number width the width of the sprite.
--- @param height number the height of the sprite.
--- @param frames_duration table<number, number> a table with keys from 1 to the number of sprites.
--- Each key must have the duration of its sprite, in frames.
--- @return Animation the new Animation.
function Animation:new(path, width, height, sprite_frame_data)
    local new = setmetatable(_C.Object:new(), self)

    local duration = 0
    local texture = path and love.graphics.newImage(path)
    local sprites = {}

    if sprite_frame_data then -- To allow inherit from DungeonAnimation without errors
        for i = 1, #sprite_frame_data.duration do
            duration = duration + sprite_frame_data.duration[i]
            sprites[i] = {
                quad = love.graphics.newQuad(width * (i - 1), 0, width, height, texture:getWidth(), texture:getHeight()), -- luacheck: ignore
                end_frame = duration / 60
            }
        end
    end

    new.texture = texture
    new.sprites = sprites
    new.current_sprite = 1
    new.current_time = 0
    new.duration = duration / 60
    new.position = sprite_frame_data and sprite_frame_data.position

    return new
end

--- Updates the Animation internal parameters to show the correct sprite
-- on callback draw.
function Animation:update(dt)
    if self.current_time >= self.sprites[self.current_sprite].end_frame then
        self.current_sprite = self.current_sprite == #self.sprites and 1 or self.current_sprite + 1
    end

    self.current_time = self.current_time > self.duration and 0 or self.current_time + dt
end

--- Draws the current sprite of the Animation.
--- @param pos Vector the position to draw the Animation.
function Animation:draw(pos)
    love.graphics.draw(self.texture, self.sprites[self.current_sprite].quad, pos:get_x(), pos:get_y())
end

--- Converts the object into a string with its information.
--- @return string a string with the object information.
function Animation:__tostring()
    return string.format(
        "Animation = {current_sprite = %d/%d, " .. "current_frame = %d/%d}",
        self.current_sprite,
        #self.sprites,
        self.current_frame,
        self.duration
    )
end

return Animation
