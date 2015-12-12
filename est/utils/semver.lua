local estring = require 'est.string'

local mod = {}

function mod.parse(str)
  local pattern = 'v?([^+-]+)([+-]?)([%w-.]*)%+?([%w-.]*)'
  local v,xtype,x,y = string.match(str, pattern)

  local major, minor, patch = string.match(v, '(%d+)%.(%d+)%.(%d+)')

  local version = {
    major = tonumber(major);
    minor = tonumber(minor);
    patch = tonumber(patch);
    rtype = {};
    bmeta = {};
  }

  if xtype == '-' and estring.not_empty(x) then
    -- x is release type
    version.rtype = estring.split(x, '.')
  elseif xtype == '+' and estring.not_empty(x) then
    -- x is build metadata
    version.bmeta = estring.split(x, '.')
  end

  if estring.not_empty(y) then
    version.bmeta = estring.split(y, '.')
  end

  return version
end

function mod.tostring(version)
  local str = string.format('%s.%s.%s',
    version.major, version.minor, version.patch
  )

  if #version.rtype > 0 then
    str = str .. '-' .. table.concat(version.rtype, '.')
  end

  if #version.bmeta > 0 then
    str = str .. '+' .. table.concat(version.bmeta, '.')
  end

  return str
end

return mod
