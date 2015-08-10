local mod = {}

mod.int8  = ffi.typeof("int8_t")
mod.int16 = ffi.typeof("int16_t")
mod.int32 = ffi.typeof("int32_t")
mod.int64 = ffi.typeof("int64_t")

mod.uint8  = ffi.typeof("uint8_t")
mod.uint16 = ffi.typeof("uint16_t")
mod.uint32 = ffi.typeof("uint32_t")
mod.uint64 = ffi.typeof("uint64_t")

return mod
