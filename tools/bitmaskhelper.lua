local bits = {false, false, false, false, false, false, false, false}
local val = 0
local op = 0

local function s(b)
  return string.format("%3s", bits[b] and "X" or ".")
end

while true do
  print(s(8)..s(1)..s(2).."\t".."8 1 2".."\n"..
      s(7)..string.format("%3s",val)..s(3).."\t".."7 . 3".."\n"..
      s(6)..s(5)..s(4).."\t".."6 5 4".."\n")

  if op == 0 then
    io.write("Introduce valor bitmasking (0 para salir): ")
    op = io.read("*number")
    if op == 0 then os.exit() end
  else
    io.write("Introduce valor bitmasking (0 para resetear): ")
    op = io.read("*number")
    if op == 0 then
      bits = {false, false, false, false, false, false, false, false}
      val = 0
    end
  end


  if bits[op] ~= nil then
    val = bits[op] and val - 2 ^ (op - 1) or val + 2 ^ (op - 1)
    bits[op] = not bits[op]
  end
end
