local mod = {}

function mod.lerp(value, from, to)
  return (1 - value) * from + value * to
end

function mod.clamp(value, min, max)
  if value < min then return min end
  if value > max then return max end
  return value
end

return mod
