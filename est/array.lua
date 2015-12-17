local mod = {}

function mod.getn(a)
  return #a
end

function mod.copy(a)
  local r = {}
  for i = 1,#a do do
    r[i] = a[i]
  end
  return r
end

return mod
