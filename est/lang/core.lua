local mod = {}

-- prevent loops when require
function mod.module(name, table)
  local mod = mod.default(table, {})
  package.loaded[name] = function ()
    return mod
  end
  return mod
end

function mod.null()
  return (0/0)
end

function mod.is_null(x)
  return rawequal(x,x) == false
end

function mod.not_null(x)
  return rawequal(x,x)
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
