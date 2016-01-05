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

function mod.front(a)
  return a[1]
end

function mod.push_front(a, value)
  table.insert(a, 1, value)
end

function mod.pop_front(a)
  table.remove(a, 1)
end

function mod.back(a)
  return a[#a]
end

function mod.push_back(a, value)
  a[#a + 1] = value
end

function mod.pop_back(a)
  a[#a] = nil
end

function mod.append(a, b)
  for i = 1,#b do
    a[#a + 1] = b[i]
  end
end

function mod.shuffle(a)
  for i = #a, 2, -1 do
    local j = math.random(i)
    a[i], a[j] = a[j], a[i]
  end
end

function mod.reverse(a, from, to)
	from = from or 1
	to   = to   or #a

	while from < to do
		a[from], a[to] = a[to], a[from]
		from = from + 1
		to = to - 1
	end
end

function mod.rotate(a, step)
	step = step % #a

	mod.reverse(a, 1, step)
	mod.reverse(a, step + 1, #a)
	mod.reverse(a, 1, #a)
end

return mod
