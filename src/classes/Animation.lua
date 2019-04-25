--- @classmod Animation
local Animation = _C.Object:new()
Animation.__index = Animation

--- Creates an animation.
-- @param path the patch to the spritesheet.
-- @param width the width of the sprite.
-- @param height the height of the sprite.
-- @param framesDuration a table with ordered numeric keys from 1 to the number
-- of sprites. Each key must have the duration of its sprite, in frames.
function Animation:new(path, width, height, framesDuration)
  local duration = 0
  local texture = love.graphics.newImage(path)
  local sprites = {}
  local currentFrame = 1
  local currentSprite = 1

  for i = 1, #framesDuration do
    duration = duration + framesDuration[i]
    sprites[i] = {
      quad = love.graphics.newQuad(width * (i - 1), 0, width, height,
          texture:getWidth(), texture:getHeight()),
      endFrame = duration
    }
  end

  return setmetatable({
    texture = texture,
    sprites = sprites,
    currentSprite = currentSprite,
    currentFrame = currentFrame,
    duration = duration
  }, self)
end

--- Updates the animation internal parameters to show the correct sprite
-- on callback draw.
function Animation:update()
  if self.currentFrame == self.sprites[self.currentSprite].endFrame then
    self.currentSprite = self.currentSprite == #self.sprites
        and 1 or self.currentSprite + 1
  end

  self.currentFrame = (globals.frames % self.duration) + 1
end

--- Draws the current sprite of the animation.
function Animation:draw(pos)
  love.graphics.draw(self.texture, self.sprites[self.currentSprite].quad,
      pos.x, pos.y)
end

--- Converts the object into a string with its information.
-- @return a string with the object information.
function Animation:__tostring()
  return string.format("Animation = {currentSprite = %d/%d, " ..
      "currentFrame = %d/%d}", self.currentSprite, #self.sprites,
      self.currentFrame, self.duration)
end

return Animation
