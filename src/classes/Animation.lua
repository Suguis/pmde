--- @class Animation : DungeonPokemonPlayer
local Animation = _C.Object:new()
Animation.__index = Animation

--- Creates an Animation.
--- @param path string the patch to the spritesheet.
--- @param number width the width of the sprite.
--- @param height number the height of the sprite.
--- @param frames_duration table<number, table<Quad, number>> a table with keys from 1 to the number of sprites.
--- Each key must have the duration of its sprite, in frames.
--- @return Animation the new Animation.
function Animation:new(path, width, height, frames_duration)
    local duration = 0
    local texture = love.graphics.newImage(path)
    local sprites = {}
    local current_frame = 1
    local current_sprite = 1

    for i = 1, #frames_duration do
        duration = duration + frames_duration[i]
        sprites[i] = {
            quad = love.graphics.newQuad(width * (i - 1), 0, width, height, texture:getWidth(), texture:getHeight()),
            end_frame = duration
        }
    end

    return setmetatable(
        {
            texture = texture,
            sprites = sprites,
            current_sprite = current_sprite,
            current_frame = current_frame,
            duration = duration
        },
        self
    )
end

--- Updates the Animation internal parameters to show the correct sprite
-- on callback draw.
function Animation:update()
    if self.current_frame == self.sprites[self.current_sprite].end_frame then
        self.current_sprite = self.current_sprite == #self.sprites and 1 or self.current_sprite + 1
    end

    self.current_frame = (globals.frames % self.duration) + 1
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
