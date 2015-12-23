local oop = require 'est.lang.oop'

local mod = oop.class()

function mod.new(class, x,y,z)
  return oop.object(class, { x = x, y = y, z = z })
end

function mod:unpack()
  return self.x, self.y, self.z
end

return mod
