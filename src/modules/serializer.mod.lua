local function is_identifier(str)
  return str == str:match'^([%a_][%w_]*)'
end

local lua2str, str2lua

local cast_rules = {
  ['nil'     ] = function(x) return 'nil' end,
  ['boolean' ] = function(x) return x and 'true' or 'false' end,
  ['string'  ] = function(x) return string.format('%q', x) end,

  ['function'] = function(x) return error('cannot serialize function') end,
  ['userdata'] = function(x) return error('cannot serialize userdata') end,
  ['cdata'   ] = function(x) return error('cannot serialize cdata') end,

  ['number'  ] = function(x)
    return rawequal(x,x) and tostring(x) or 'null'
  end,

  ['table'] = function(x)
    local t = {}
    local i = 1

    for k in pairs(x) do
      if k == i then
        i = i + 1
        t[#t+1] = lua2str(x[k])
      else
        if type(k) == 'string' and is_identifier(k) then
          t[#t+1] = k .. '=' .. lua2str(x[k])
        else
          t[#t+1] = '[' .. lua2str(k) .. ']=' .. lua2str(x[k])
        end
      end
    end

    return table.concat {
      '{', table.concat(t, ','), '}'
    }
  end
}

function lua2str(val)
  return cast_rules[type(val)](val)
end

function str2lua(str)
  local init = 'local null = 0/0;';
  local func = loadstring(init .. 'return ' .. str)
  local ok, data = pcall(func)
  if ok then
    return data
  end
  return str
end

return {
  tolua = str2lua;
  tostr = lua2str;
}
