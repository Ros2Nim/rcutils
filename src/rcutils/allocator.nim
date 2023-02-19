##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim render nobody

##  #pragma c2nim render nobody

##  Copyright 2015 Open Source Robotics Foundation, Inc.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##  \file

import
  rcutils.macros, rcutils.macros, rcutils.macros, rcutils.macros, rcutils.macros,
  rcutils.types.rcutils_ret, rcutils.visibility_control,
  rcutils.visibility_control_macros, rcutils.visibility_control_macros,
  rcutils.visibility_control

type

  rcutils_allocator_t* {.importc: "rcutils_allocator_t", header: "allocator.h",
                        bycopy.} = object ##  Encapsulation of an allocator.
                                       ##
                                       ##  The default allocator uses malloc(), free(), calloc(), and realloc().
                                       ##  It can be obtained using rcutils_get_default_allocator().
                                       ##
                                       ##  The allocator should be trivially copyable.
                                       ##  Meaning that the struct should continue to work after being assignment
                                       ##  copied into a new struct.
                                       ##  Specifically the object pointed to by the state pointer should remain valid
                                       ##  until all uses of the allocator have been made.
                                       ##  Particular care should be taken when giving an allocator to functions like
                                       ##  rcutils_*_init() where it is stored within another object and used later.
                                       ##  Developers should note that, while the fields of a const-qualified allocator
                                       ##  struct cannot be modified, the state of the allocator can be modified.
                                       ##
    allocate* {.importc: "allocate".}: proc (size: csize_t; state: pointer): pointer {.
        cdecl.} ##  Allocate memory, given a size and the `state` pointer.
               ##  An error should be indicated by returning `NULL`.
    ##  Deallocate previously allocated memory, mimicking free().
    deallocate* {.importc: "deallocate".}: proc (pointer: pointer; state: pointer) {.
        cdecl.}               ##  Also takes the `state` pointer.
    ##  Reallocate if possible, otherwise it deallocates and allocates.
    reallocate* {.importc: "reallocate".}: proc (pointer: pointer; size: csize_t;
        state: pointer): pointer {.cdecl.} ##
                                       ##  Also takes the `state` pointer.
                                       ##
                                       ##  If unsupported then do deallocate and then allocate.
                                       ##  This should behave as realloc() does, as opposed to posix's
                                       ##
                                       ## [reallocf](https://linux.die.net/man/3/reallocf), i.e. the memory given
                                       ##  by pointer will not be free'd automatically if realloc() fails.
                                       ##  For reallocf-like behavior use rcutils_reallocf().
                                       ##  This function must be able to take an input pointer of `NULL` and succeed.
                                       ##
    ##  Allocate memory with all elements set to zero, given a number of elements and their size.
    zero_allocate* {.importc: "zero_allocate".}: proc (number_of_elements: csize_t;
        size_of_element: csize_t; state: pointer): pointer {.cdecl.} ##
                              ##  An error should be indicated by returning `NULL`.
    ##  Implementation defined state storage.
    state* {.importc: "state".}: pointer ##
                                     ##  This is passed as the final parameter to other allocator functions.
                                     ##  Note that the contents of the state can be modified even in const-qualified
                                     ##  allocator objects.
                                     ##



proc rcutils_get_zero_initialized_allocator*(): rcutils_allocator_t {.cdecl,
    importc: "rcutils_get_zero_initialized_allocator", header: "allocator.h".}
  ##  Return a zero initialized allocator.
  ##
  ##  Note that this is an invalid allocator and should only be used as a placeholder.
  ##

proc rcutils_get_default_allocator*(): rcutils_allocator_t {.cdecl,
    importc: "rcutils_get_default_allocator", header: "allocator.h".}
  ##  Return a properly initialized rcutils_allocator_t with default values.
  ##
  ##  This defaults to:
  ##
  ##  - allocate = wraps malloc()
  ##  - deallocate = wraps free()
  ##  - reallocate = wraps realloc()
  ##  - zero_allocate = wraps calloc()
  ##  - state = `NULL`
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | No
  ##  Thread-Safe        | Yes
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##

proc rcutils_allocator_is_valid*(allocator: ptr rcutils_allocator_t): bool {.cdecl,
    importc: "rcutils_allocator_is_valid", header: "allocator.h".}
  ##  Return true if the given allocator has non-null function pointers.
  ##
  ##  \param[in] allocator to be checked by the function
  ##  \return `true` if the allocator is valid, `false` otherwise.
  ##
##  Check the given allocator and run fail_statement if it is not valid.

##  Check the given allocator, and set the message in msg and run fail_statement if it is not valid.


proc rcutils_reallocf*(pointer: pointer; size: csize_t;
                      allocator: ptr rcutils_allocator_t): pointer {.cdecl,
    importc: "rcutils_reallocf", header: "allocator.h".}
  ##  Emulate the behavior of [reallocf](https://linux.die.net/man/3/reallocf).
  ##
  ##  This function will return `NULL` if the allocator is `NULL` or has `NULL` for
  ##  function pointer fields.
  ##  \param[inout] pointer to the memory which will be reallocated
  ##  \param[in] size in bytes
  ##  \param[in] allocator to be used to allocate and deallocate memory
  ## 