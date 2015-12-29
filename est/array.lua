local mod = {}

function mod.size(a)
  return #a
end

function mod.copy(a)
  local r = {}
  for i = 1,#a do
    r[i] = a[i]
  end
  return r
end

function mod.fill(a, from, to, value)
  for i = from, to do
    a[i] = value
  end
end

function mod.fill_ex(a, from, to, fillf)
  for i = from, to do
    a[i] = fillf(i, a)
  end
end

function mod.find(a, what, from)
  for i = from,#a do
    if a[i] == what then
      return i
    end
  end
  return nil
end

function mod.find_all(a, what, from)
  local r = {}
  for i = from,#a do
    if a[i] == what then
      r[#r + 1] = i
    end
  end
  return r
end

function mod.match(a, match_func, from)
  for i = from,#a do
    if match_func(i,a[i],a) then
      return i
    end
  end
  return nil
end

function mod.match_all(a, match_func, from)
  local r = {}
  for i = from,#a do
    if match_func(i,a[i],a) then
      r[#r + 1] = i
    end
  end
  return r
end

return mod
