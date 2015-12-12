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

  if xtype == '-' and x then
    -- x is release type
    version.rtype = estring.split(x, '.')
  elseif xtype == '+' and x then
    -- x is build metadata
    version.bmeta = estring.split(x, '.')
  end

  if y then
    version.bmeta = estring.split(y, '.')
  end

  return version
end

return mod
