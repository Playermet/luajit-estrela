local mod = {}

mod.const = {
  whitespace  = [[\32\t\n\v\f\r]];
  punctuation = [[!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]];
  uppercase   = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ]];
  lowercase   = [[abcdefghijklmnopqrstuvwxyz]];
  digits      = [[0123456789]];
}

function mod.is_empty(s)
  return type(s) == 'string' and #s == 0
end

function mod.not_empty(s)
  return type(s) == 'string' and #s > 0
end

function mod.nil_or_empty(s)
  return mod.is_empty(s) or s == nil
end

function mod.count(s, sub, use_pattern)
  local c = 0

  local start = 0
  local from, to = string.find(s, sub, start, not use_pattern)
  while from do
    c = c + 1
    start = to + 1
    from, to = string.find(s, sub, start, not use_pattern)
  end

  return c
end

function mod.find_all(s, sub, use_pattern)
  local t = {}

  local start = 0
  local from, to = string.find(s, sub, start, not use_pattern)
  while from do
    t[#t + 1] = { from, to }
    start = to + 1
    from, to = string.find(s, sub, start, not use_pattern)
  end

  return t
end

function mod.split(s, d, use_pattern)
  local t = {}

  local start = 1
  local from, to = string.find(s, d, 1, not use_pattern)
  while from do
    t[#t + 1] = string.sub(s, start, from - 1)
    start = to + 1
    from, to = string.find(s, d, start, not use_pattern)
  end
  t[#t + 1] = string.sub(s, start)

  return t
end

function mod.partition(s, d, use_pattern)
  local from, to = string.find(s, d, 1, not use_pattern)
  if from then
    local a = string.sub(s, 1, from - 1)
    local b = string.sub(s, from, to)
    local c = string.sub(s, to + 1, #s)
    return a,b,c
  end
  return nil
end

function mod.starts(s, sub, use_pattern)
  local from, _ = string.find(s, sub, 1, not use_pattern)
  if from == 1 then
    return true
  end
  return false
end

function mod.ends(s, sub, use_pattern)
  if use_pattern then
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
