
import allocator

type
  RcutilsNimAllocator = ref rcutils_allocator_t

proc ralloc(size: csize_t, state: pointer): pointer {.cdecl, raises: [].} =
  try:
    result = allocShared(size.Natural)
  except OutOfMemDefect:
    result = nil
proc rdealloc(memory: pointer, state: pointer) {.cdecl, raises: [].} =
  try:
    deallocShared(memory)
  except OutOfMemDefect:
    discard
proc rrealloc(memory: pointer, size: csize_t, state: pointer): pointer {.cdecl, raises: [].} =
  try:
    result = reallocShared(memory, size.Natural)
  except OutOfMemDefect:
    result = nil
proc rzealloc(count, size: csize_t, state: pointer): pointer {.cdecl, raises: [].} =
  try:
    result = allocShared0(count * size)
  except OutOfMemDefect:
    result = nil

proc newRcutilsAllocator*(): RcutilsNimAllocator =
  new result
  result.allocate = ralloc
  result.deallocate = rdealloc
  result.reallocate = rrealloc
  result.zero_allocate = rzealloc
  result.state = nil
