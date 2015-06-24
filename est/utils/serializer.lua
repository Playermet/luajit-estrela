local mod = {}
local aux = {}

function mod.tostr(val)
  return mod.rules[type(val)](val)
end

function mod.tolua(str)
  local init = 'local null = 0/0;'
  local func = loadstring(init .. 'return ' .. str)
  local ok, data = pcall(func)
  if ok then
    return data
  end
  error('cannot deserialize string: ' .. data, 2)
end


aux.keywords = {
  ['and']      = 1;
  ['break']    = 1;
  ['do']       = 1;
  ['else']     = 1;
  ['elseif']   = 1;
  ['end']      = 1;
  ['false']    = 1;
  ['for']      = 1;
  ['function'] = 1;
  ['goto']     = 1;
  ['if']       = 1;
  ['in']       = 1;
  ['local']    = 1;
  ['nil']      = 1;
  ['not']      = 1;
  ['or']       = 1;
  ['repeat']   = 1;
  ['return']   = 1;
  ['then']     = 1;
  ['true']     = 1;
  ['until']    = 1;
  ['while']    = 1;
}

function aux.is_plain_key(key)
  return key == key:match('^[%a_][%w_]*$') and aux.keywords[key] == nil
end


mod.rules = {
  ['nil'     ] = function(x) return 'nil' end,
  ['boolean' ] = function(x) return x and 'true' or 'false' end,
  ['string'  ] = function(x) return string.format('%q', x) end,

  ['function'] = function(x) error('cannot serialize function') end,
  ['userdata'] = function(x) error('cannot serialize userdata') end,
  ['cdata'   ] = function(x) error('cannot serialize cdata') end,

  ['number'  ] = function(x)
    return rawequal(x,x) and tostring(x) or 'null'
  end,

  ['table'] = function(x)
    local t = {}
    local i = 1

    for k in pairs(x) do
      if k == i then
        i = i + 1
        t[#t+1] = mod.tostr(x[k])
      else
        if type(k) == 'string' and aux.is_plain_key(k) then
          t[#t+1] = k .. '=' .. mod.tostr(x[k])
        else
          t[#t+1] = '[' .. mod.tostr(k) .. ']=' .. mod.tostr(x[k])
        end
      end
    end

    return '{' .. table.concat(t, ',') .. '}'
  end
}

return mod
