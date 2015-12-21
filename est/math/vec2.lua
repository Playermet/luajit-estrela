local oop = require 'est.lang.oop'

local mod = oop.class()

function mod.new(class, x,y)
  return oop.object(class, { x = x, y = y })
end

function mod:unpack()
  return self.x, self.y
end

return mod
