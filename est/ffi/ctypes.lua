local ffi = require 'ffi'

local mod = {}

mod.void = ffi.typeof('void')

mod.int8  = ffi.typeof('int8_t')
mod.int16 = ffi.typeof('int16_t')
mod.int32 = ffi.typeof('int32_t')
mod.int64 = ffi.typeof('int64_t')

mod.uint8  = ffi.typeof('uint8_t')
mod.uint16 = ffi.typeof('uint16_t')
mod.uint32 = ffi.typeof('uint32_t')
mod.uint64 = ffi.typeof('uint64_t')

mod.float  = ffi.typeof('float')
mod.double = ffi.typeof('double')

function mod.array(ct)
  return ffi.typeof('$[?]', ct)
end

function mod.ptr(ct)
  return ffi.typeof('$*', ct)
end

function mod.ref(ct)
  return ffi.typeof('$&', ct)
end

-- short aliases
mod.char  = mod.int8
mod.wchar = mod.int16
mod.short = mod.int16
mod.int   = mod.int32
mod.long  = mod.int32

mod.uchar  = mod.uint8
mod.uwchar = mod.uint16
mod.ushort = mod.uint16
mod.uint   = mod.uint32
mod.ulong  = mod.uint32

return mod
