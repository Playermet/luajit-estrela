local mod = {}

function mod.class(class)
  class = class or {}
  class.__index = class
  return class
end

function mod.extend(class, base)
  for k,v in pairs(base) do
    if class[k] == nil then
      class[k] = v
    end
  end
end

function mod.object(class, object)
  return setmetatable(object, class)
end

function mod.classof(object)
  return getmetatable(object)
end

return mod
