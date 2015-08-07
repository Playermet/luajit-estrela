local mod = {}

function mod.getn(x)
  if aux.istable(x) then
    local r = 0
    for _,v in pairs(x) do
      r = r + mod.getn(v)
    end
    return r
  end
  return 1
end

function mod.copy(x)
  if aux.istable(x) then
    local r = {}
    for k,v in pairs(x) do
      r[k] = mod.copy(v)
    end
    return r
  end
  return x
end

function mod.diff(x,y)
  if aux.istable(x) and aux.istable(y) then
    local diff = {}
    for k in pairs(y) do
      diff[k] = mod.diff(x[k],y[k])
    end
    for k in pairs(x) do
      if y[k] == nil then
        diff[k] = aux.null
      end
    end
    if next(diff) then
      return diff
    end
  end
  if x ~= y then
    return y
  end
end

function mod.apply(x, diff)
  if aux.istable(x) and aux.istable(diff) then
    for k in pairs(diff) do
      x[k] = mod.apply(x[k], diff[k])
    end
  end
  if aux.notnull(diff) then
    return diff
  end
end

function mod.merge(x,y)
  if aux.istable(x) and aux.istable(y) then
    local merged = {}
    for k in pairs(y) do
      merged[k] = mod.merge(x[k],y[k])
    end
    return merged
  end
  if aux.notnull(y) then
    return y
  end
end

function mod.binary(x,y, func)
  if aux.istable(x) and aux.istable(y) then
    local d = {}
    for k in pairs(y) do
      d[k] = mod.binary(x[k],y[k], func)
    end
    if next(d) then
      return d
    end
  end
  return func(x[k],y[k])
end

function mod.hasloops(x, map)
  if aux.istable(x) then
    map = map or {}
    if map[x] then
      return true
    end
    map[x] = x
    for k in pairs(x) do
      local r = mod.hasloops(x[k], map)
      if r then
        return true
      end
    end
    map[x] = nil
  end
  return false
end

aux.null = (0/0)

function aux.notnull(x)
  return rawequal(x,x)
end

function aux.istable(x)
  return type(x) == 'table'
end

return mod
