local mod = {}

local class_mt = {}

function class_mt:__call(...)
  local object = setmetatable({}, self)
  local constructor = self.__init
  if type(constructor) == 'function' then
    constructor(object, ...)
  end
  return object
end

function mod.class()
  local new_class = {}
  new_class.__index = new_class
  setmetatable(new_class, class_mt)
  return new_class
end

return mod
