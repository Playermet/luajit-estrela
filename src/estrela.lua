-----------------------------------------------------------
--  Estrela
-----------------------------------------------------------
local estrela = {}
local modules = {}
local cache   = {}

estrela.modules = modules
estrela.cache   = cache

local function splitpath(path)
  local pattern = [[(.-)([^\/.]*)([^\/]-)$]]
  local dir, name, ext = path:match(pattern)
  return {
    full = path;
    dir  = dir;
    name = name;
    ext  = ext;
  }
end

if jit.os == 'Windows' then

  function estrela.scan(scanpath, format)
    local cmd = 'dir "' .. scanpath .. '\\'
              .. (format or '*.mod.lua')
              .. '" /b /a:-d /s /l'

    for modpath in io.popen(cmd):lines() do
      local path = splitpath(modpath)
      modules[path.name] = { path = path }
    end
  end

else
  error 'Missing scan method for current platform'
end

function estrela.require(name)
  if not cache[name] then
    assert(modules[name], 'Module not exist')

    local temp   = package.path
    package.path = modules[name].path.dir .. '?.lua;' .. package.path
    cache[name]  = { loadfile(modules[name].path.full)() }
    package.path = temp
  end

  return unpack(cache[name])
end

return estrela
