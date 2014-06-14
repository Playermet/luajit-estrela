-----------------------------------------------------------
--  Estrela
-----------------------------------------------------------
local modules = {}
local cache   = {}

local register, scan, require

function register(path)
  local pattern = [[(.-)([^\/]*)%.mod%.lua$]]
  local dir, name = path:match(pattern)
  modules[name] = { path = path, dir = dir }
end

if jit.os == 'Windows' then

  function scan(scanpath)
    local cmd = 'dir "' .. scanpath .. '\\'
              .. '*.mod.lua'
              .. '" /b /a:-d /s /l'

    for modpath in io.popen(cmd):lines() do
      register(modpath)
    end
  end

else
  error 'Missing scan method for current platform'
end

function require(name)
  if not cache[name] then
    assert(modules[name], 'Module not exist')

    local temp   = package.path
    package.path = modules[name].dir .. '?.lua;' .. package.path
    cache[name]  = { loadfile(modules[name].path)() }
    package.path = temp
  end

  return unpack(cache[name])
end

return {
  scan    = scan;
  require = require;
  modules = modules;
  cache   = cache;
}
