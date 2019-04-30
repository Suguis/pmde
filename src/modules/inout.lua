local inout = {}

--- @type table
local read_data
local animation_env = {}

--- Reads an animation. This function is used internally by `animation.lua` files.
function animation_env.animation(t)
    read_data = t
end

--- Reads the animation data from a file
--- @param file string the path to the file
--- @return table the animation data
function inout.read_animation(file)
    read_data = {}
    loadfile(file, nil, animation_env)()
    return read_data
end

return inout
