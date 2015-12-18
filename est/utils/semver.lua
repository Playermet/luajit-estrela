local estring = require 'est.string'

local mod = {}

function mod.create(major, minor, patch)
  local version = {
    major = tonumber(major);
    minor = tonumber(minor);
    patch = tonumber(patch);
    rtype = {};
    bmeta = {};
  }
  return version
end

function mod.clone(version)
  local clone = {
    major = tonumber(version.major);
    minor = tonumber(version.minor);
    patch = tonumber(version.patch);
    rtype = { unpack(version.rtype) };
    bmeta = { unpack(version.bmeta) };
  }
  return clone
end

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

-- is safe to use b instead of a
function mod.is_compatible(a,b)
  if type(a) == 'string' then
    a = mod.parse(a)
  end
  if type(b) == 'string' then
    b = mod.parse(b)
  end
  return a.major == b.major and a.minor <= b.minor
end

-- compare main part
function mod.compare(a,b)
  if type(a) == 'string' then
    a = mod.parse(a)
  end
  if type(b) == 'string' then
    b = mod.parse(b)
  end

  if a.major == b.major then
    if a.minor == b.minor then
      if a.patch == b.patch then
        return 0
      end
      return a.patch > b.patch and 1 or -1
    end
    return a.minor > b.minor and 1 or -1
  end
  return a.major > b.major and 1 or -1
end

function mod.less(a,b)
  return mod.compare(a,b) == -1
end

function mod.greater(a,b)
  return mod.compare(a,b) == 1
end

function mod.equal(a,b)
  return mod.compare(a,b) == 0
end

function mod.inc_major(version)
  version.major = version.major + 1
  version.minor = 0
  version.patch = 0
end

function mod.inc_minor(version)
  version.minor = version.minor + 1
  version.patch = 0
end

function mod.inc_patch(version)
  version.patch = version.patch + 1
end

return mod
