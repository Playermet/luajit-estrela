-----------------------------------------------------------
--  Simple OOP
-----------------------------------------------------------
local function new(metatable, ...)
  local object = {}

  setmetatable(object, metatable)

  local constructor = rawget(metatable, '__init')
  if (constructor ~= nil) then
    constructor(object, ...)
  end

  return object
end

local function class(name)
  local metatable = {}

  metatable.__class = name
  metatable.__index = metatable

  setmetatable(metatable, { __call = new })

  return metatable
end

return {
  class = class
}
