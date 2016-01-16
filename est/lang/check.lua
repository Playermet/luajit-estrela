local mod = {}

function mod.not_nil(x)
  return x ~= nil
end

function mod.same_type(x,y)
  return type(x) == type(y)
end

function mod.not_same_type(x,y)
  return type(x) ~= type(y)
end

function mod.boolean(x)
  return type(x) == 'boolean'
end

function mod.number(x)
  return type(x) == 'number'
end

function mod.not_zero(x)
  return x ~= 0
end

function mod.positive(x)
  return x > 0
end

function mod.negative(x)
  return x < 0
end

function mod.not_positive(x)
  return x <= 0
end

function mod.not_negative(x)
  return x >= 0
end

function mod.integer(x)
  return x == math.floor(x)
end

function mod.in_range(x, min, max)
  return x >= min and x <= max
end

function mod.nan(x)
  return not rawequal(x,x)
end

function mod.not_nan(x)
  return rawequal(x,x)
end

function mod.string(x)
  return type(x) == 'string'
end

function mod.empty_string(x)
  return #x == 0
end

function mod.not_empty_string(x)
  return #x > 0
end

function mod.function(x)
  return type(x) == 'function'
end

function mod.table(x)
  return type(x) == 'table'
end

function mod.empty_table(x)
  return next(x) == nil
end

function mod.not_empty_table(x)
  return next(x) ~= nil
end

function mod.empty_array(x)
  return #x == 0
end

function mod.not_empty_array(x)
  return #x > 0
end

function mod.has_fields(x)
  return next(x, #x) ~= nil
end

function mod.not_has_fields(x)
  return next(x, #x) == nil
end

function mod.class(x)
  return mod.table(x) and x == x.__index
end

function mod.object(x)
  return mod.class(getmetatable(x))
end

function mod.objectof(x, y)
  return getmetatable(x) == y
end

function mod.has_field(x, field)
  return x[field] ~= nil
end

function mod.has_mt(x)
  return getmetatable(x) ~= nil
end

function mod.has_mt_field(x, field)
  local mt = getmetatable(x)
  if mod.is_table(mt) then
    return mod.is_function(mt[field])
  end
  return false
end

function mod.callable(x)
  return mod.function(x) or mod.has_mt_field(x, '__call')
end

function mod.comparable(x)
  return mod.number(x) or mod.string(x) or mod.has_mt_field(x, '__lt')
end

function mod.indexable(x)
  return mod.table(x) or mod.has_mt_field(x, '__index')
end

function mod.writable(x)
  return mod.table(x) or mod.has_mt_field(x, '__newindex')
end

function mod.iterable(x)
  return mod.table(x) or mod.has_mt_field(x, '__pairs')
end

function mod.userdata(x)
  return type(x) == 'userdata'
end

function mod.thread(x)
  return type(x) == 'thread'
end

function mod.ctype(x)
  return type(x) == 'cdata'
end

function mod.file(x)
  return getmetatable(x) == getmetatable(io.stdout)
end

return mod
