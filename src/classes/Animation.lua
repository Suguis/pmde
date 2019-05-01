--- @class Animation : DungeonPokemonPlayer
local Animation = _C.Object:new_void()
Animation.__index = Animation

--- Creates an Animation.
--- @param path string the patch to the spritesheet.
--- @param frames_duration table<number, number> a table with keys from 1 to the number of sprites.
--- Each key must have the duration of its sprite, in frames.
--- @return Animation the new Animation.
function Animation:new(path, sprite_frame_data)
    local new = setmetatable(_C.Object:new(), self)

    local duration = 0
    local texture = love.graphics.newImage(path)
    local texture_width, texture_height = texture:getDimensions()
    local animation_width = texture_width / #sprite_frame_data.duration
    local sprites = {}

    for i = 1, #sprite_frame_data.duration do
        duration = duration + sprite_frame_data.duration[i]
        sprites[i] = {
            quad = love.graphics.newQuad(
                animation_width * (i - 1),
                0,
                animation_width,
                texture_height,
                texture_width,
                texture_height
            ),
            end_frame = duration / 60
        }
    end

    new.texture = texture
    new.sprites = sprites
    new.current_sprite = 1
    new.start_time = sprite_frame_data.start / 60
    new.current_time = new.start_time
    new.duration = duration / 60
    new.position = sprite_frame_data and sprite_frame_data.position
    new.width = animation_width
    new.height = texture_height
    new.mirror_x = false
    new.mirror_y = false

    return new
end

--- Creates an Animation with no atributes, useful for inheritance.
--- @return Animation a new void Animation.
function Animation:new_void()
    return setmetatable(_C.Object:new_void(), self)
end

--- Gets  if the animation is mirroring in the x axis
--- @return boolean if the animation is mirror in the x axis
function Animation:get_mirror_x()
    return self.mirror_x
end

--- Sets if the animation will mirror in the x axis
--- @param value boolean if the animation will mirror in the x axis
function Animation:set_mirror_x(value)
    self.mirror_x = value
end

--- Updates the Animation internal parameters to show the correct sprite
-- on callback draw.
function Animation:update(dt)
    if self.current_time >= self.sprites[self.current_sprite].end_frame then
        self.current_sprite = self.current_sprite == #self.sprites and 1 or self.current_sprite + 1
    end

    self.current_time = self.current_time > self.duration and 0 or self.current_time + dt
end

--- Resets the animation time
function Animation:reset()
    self.current_time = self.start_time
    self.current_sprite = 1
end

--- Draws the current sprite of the Animation.
--- @param pos Vector the position to draw the Animation.
function Animation:draw(pos)
    love.graphics.draw(
        self.texture,
        self.sprites[self.current_sprite].quad,
        pos:get_x() + (self.mirror_x and self.width or 0),
        pos:get_y() + (self.mirror_y and self.height or 0),
        0,
        self.mirror_x and -1 or 1,
        self.mirror_y and -1 or 1
    )
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
