local mod = {}

function mod.size(t)
  local r = 0
  for _ in pairs(t) do
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

function mod.values(t)
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

function mod.flip(t)
  local r = {}
  for k,v in pairs(t) do
    r[v] = k
  end
  return r
end

function mod.find(t, what, from)
  for k,v in next,t,from  do
    if v == what then
      return k
    end
  end
  return nil
end

function mod.find_all(t, what, from)
  local r = {}
  for k,v in next,t,from  do
    if v == what then
      r[#r + 1] = k
    end
  end
  return r
end

function mod.match(t, match_func, from)
  for k,v in next,t,from  do
    if match_func(k,v,t) then
      return k
    end
  end
  return nil
end

function mod.match_all(t, match_func, from)
  local r = {}
  for k,v in next,t,from  do
    if match_func(k,v,t) then
      r[#r + 1] = k
    end
  end
  return r
end

return mod
