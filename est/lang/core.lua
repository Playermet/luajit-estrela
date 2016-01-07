local mod = {}

-- prevent loops when require
function mod.module(name, table)
  local mod = mod.default(table, {})
  package.loaded[name] = function ()
    return mod
  end
  return mod
end

function mod.default(value, default)
  if value ~= nil then
    return value
  end
  return default
end

function mod.ternary(condition, if_value, else_value)
  if condition then
    return if_value
  end
  return else_value
end

return mod
