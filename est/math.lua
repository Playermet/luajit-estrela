local mod = {}

function mod.lerp(value, from, to)
  return (1 - value) * from + value * to
end

function mod.clamp(value, min, max)
  if value < min then return min end
  if value > max then return max end
  return value
end

function mod.round(value)
  if value >= 0 then
    return math.floor(value + 0.5)
  end
  return math.ceil(value - 0.5)
end

function mod.trunc(x)
  return (math.modf(x))
end

function mod.floor_by(value, quantum)
  return math.floor(value / quantum) * quantum
end

function mod.ceil_by(value, quantum)
  return math.ceil(value / quantum) * quantum
end

function mod.round_by(value, quantum)
  return mod.round(value / quantum) * quantum
end

function mod.sign(x)
  if x > 0 then
    return 1
  elseif x < 0 then
    return -1
  end
  return 0
end

-- greatest common divisor
function mod.gcd(x, y)
  while x ~= 0 do
    x, y = y % x, x
  end
  return y
end

-- least common multiple
function mod.lcm(x, y)
  return (x * y) / mod.gcd(x, y)
end

return mod
