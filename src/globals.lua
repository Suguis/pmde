--- Global variables module
-- @module globals
local globals

--- A table containing own defined global variables
globals = {
  CELL_SIZE = 24,  -- the size of the cells, in pixels.
  TILESET_WIDTH = 432,  -- the width of the tilesets images.
  TILESET_HEIGHT = 576,  -- the width of the tilesets images.
  TILES_DISPLAY_WIDTH = 11,  -- The number of tile columns that can be displayed.
  TILES_DISPLAY_HEIGHT = 8,  -- The number of tile rows that can be displayed.
  time = 0,  -- the time passed in seconds since the beggining of the game.
  frames = 0,  -- the frames passed since the beggining of the game.
  actions = require "src.actions"
}

return globals
