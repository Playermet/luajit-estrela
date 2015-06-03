local mod = {}

mod.const = {
  whitespace  = [[\32\t\n\v\f\r]];
  punctuation = [[!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]];
  uppercase   = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ]];
  lowercase   = [[abcdefghijklmnopqrstuvwxyz]];
  digits      = [[0123456789]];
}

function mod.count(s, d, pattern)
  local c = 0

  local start = 0
  local from, to = string.find(s, d, start, not pattern)
  while from do
    c = c + 1
    start = to + 1
    from, to = string.find(s, d, start, not pattern)
  end

  return c
end

function mod.findall(s, d, pattern)
  local t = {}

  local start = 0
  local from, to = string.find(s, d, start, not pattern)
  while from do
    t[#t + 1] = { from, to }
    start = to + 1
    from, to = string.find(s, d, start, not pattern)
  end

  return t
end

function mod.split(s, d, pattern)
  local t = {}

  local start = 1
  local from, to = string.find(s, d, 1, not pattern)
  while from do
    t[#t + 1] = string.sub(s, start, from - 1)
    start = to + 1
    from, to = string.find(s, d, start, not pattern)
  end
  t[#t + 1] = string.sub(s, start)

  return t
end

function mod.partition(s, d, pattern)
  local from, to = string.find(s, d, 1, not pattern)
  if from then
    local a = string.sub(s, 1, from - 1)
    local b = string.sub(s, from, to)
    local c = string.sub(s, to + 1, #s)
    return a,b,c
  end
  return nil
end

function mod.starts(s, sub, pattern)
  local from, _ = string.find(s, sub, 1, not pattern)
  if from == 1 then
    return true
  end
  return false
end

function mod.ends(s, sub, pattern)
  if pattern then
    local all  = mod.findall(s, sub, true)
    local last = all[#all]
    if last and last[2] == #s then
      return true
    end
  else
    local _, to = string.find(s, sub, -#sub, false)
    if to == #s then
      return true
    end
  end
  return false
end

function mod.totable(s)
  local t = {}
  for i = 1, #s do
    t[i] = string.sub(s, i, i)
  end
  return t
end

function mod.at(s, i)
  return string.sub(s, i, i)
end

return mod
