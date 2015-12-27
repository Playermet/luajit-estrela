local mod = {}

function mod.trim(s)
  return string.match(s, '^%s*(.*)%s*$')
end

return mod
