local mod = {}

function mod.class(class, ...)
  class = class or {}
  class.__index = class
  return class, mod
end

function mod.object(class, object)
  return setmetatable(object, class)
end

function mod.classof(object)
  return getmetatable(object)
end

return mod
