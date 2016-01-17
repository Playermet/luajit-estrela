local oop = require 'est.lang.oop'

local mod = oop.class()

function mod.new(class, x,y,z)
  return oop.object(class, { x = x, y = y, z = z })
end

function mod:unpack()
  return self.x, self.y, self.z
end

function mod:copy()
  return mod:new(self.x, self.y, self.z)
end

function mod:assign(v)
  self.x = v.x
  self.y = v.y
  self.z = v.z
end

function mod:setxyz(x,y,z)
  self.x = x
  self.y = y
  self.z = z
end

return mod
