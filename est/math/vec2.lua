local oop = require 'est.lang.oop'

local mod = oop.class()

function mod.new(class, x,y)
  return oop.object(class, { x = x, y = y })
end

function mod:unpack()
  return self.x, self.y
end

function mod:copy()
  return mod:new(self.x, self.y)
end

function mod:assign(v)
  self.x = v.x
  self.y = v.y
end

function mod:setxy(x,y)
  self.x = x
  self.y = y
end

return mod
