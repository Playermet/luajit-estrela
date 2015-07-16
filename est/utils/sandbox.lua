local mod = {}

function mod.get_safe_env()
  return {
    _VERSION = _VERSION,
    assert   = assert,
    coroutine = {
      create  = coroutine.create,
      resume  = coroutine.resume,
      running = coroutine.running,
      status  = coroutine.status,
      wrap    = coroutine.wrap,
      yield   = coroutine.yield
    },
    error  = error,
    ipairs = ipairs,
    math = {
      abs    = math.abs,
      acos   = math.acos,
      asin   = math.asin,
      atan   = math.atan,
      atan2  = math.atan2,
      ceil   = math.ceil,
      cos    = math.cos,
      cosh   = math.cosh,
      deg    = math.deg,
      exp    = math.exp,
      floor  = math.floor,
      fmod   = math.fmod,
      frexp  = math.frexp,
      huge   = math.huge,
      ldexp  = math.ldexp,
      log    = math.log,
      log10  = math.log10,
      max    = math.max,
      min    = math.min,
      modf   = math.modf,
      pi     = math.pi,
      pow    = math.pow,
      rad    = math.rad,
      random = math.random,
      sin    = math.sin,
      sinh   = math.sinh,
      sqrt   = math.sqrt,
      tan    = math.tan,
      tanh   = math.tanh
    },
    next = next,
    os = {
      clock = os.clock,
      time  = os.time
    },
    pairs  = pairs,
    pcall  = pcall,
    print  = print,
    select = select,
    string = {
      byte    = string.byte,
      char    = string.char,
      find    = string.find,
      format  = string.format,
      gmatch  = string.gmatch,
      gsub    = string.gsub,
      len     = string.len,
      lower   = string.lower,
      match   = string.match,
      rep     = string.rep,
      reverse = string.reverse,
      sub     = string.sub,
      upper   = string.upper
    },
    table = {
      insert = table.insert,
      maxn   = table.maxn,
      remove = table.remove,
      sort   = table.sort
    },
    tonumber = tonumber,
    tostring = tostring,
    type     = type,
    unpack   = unpack,
    xpcall   = xpcall
  }
end

function mod.make_clean_env(env)
  return setmetatable({}, { __index = env })
end

function mod.reset_clean_env(env)
  return setmetatable(env, nil)
end

function mod.run(code, env, ...)
  local func, msg = load(code, nil, 't', env)
  if func then
    return pcall(func, ...)
  end
  return nil, msg
end

return mod
