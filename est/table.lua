local mod = {}

function mod.getn(t)
  local r = 0
  for k,v in pairs(t) do
    r = r + 1
  end
  return r
end

function mod.keys(t)
  local r = {}
  for k in pairs(t) do
    r[#r + 1] = k
  end
  return r
end

function mod.vals(t)
  local r = {}
  for _,v in pairs(t) do
    r[#r + 1] = v
  end
  return r
end

function mod.copy(t)
  local r = {}
  for k,v in pairs(t) do
    r[k] = v
  end
  return r
end

return mod
