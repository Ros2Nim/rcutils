##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim render nobody

##  #pragma c2nim render nobody

##  Copyright 2018 Open Source Robotics Foundation, Inc.
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
  rcutils.allocator, rcutils.allocator, rcutils.allocator, rcutils.macros,
  rcutils.macros, rcutils.macros, rcutils.macros, rcutils.macros, rcutils.allocator,
  rcutils.types.rcutils_ret, rcutils.allocator, rcutils.visibility_control,
  rcutils.visibility_control_macros, rcutils.visibility_control_macros,
  rcutils.visibility_control, rcutils.allocator

type

  rcutils_uint8_array_t* {.importc: "rcutils_uint8_array_t",
                          header: "uint8_array.h", bycopy.} = object ##
                              ##  The structure holding the metadata for a uint8 array.
    buffer* {.importc: "buffer".}: ptr uint8 ##  The allocated memory for the uint8 array.
    buffer_length* {.importc: "buffer_length".}: csize_t ##
                              ##  The number of valid elements in the uint8 array.
    buffer_capacity* {.importc: "buffer_capacity".}: csize_t ##
                              ##  The maximum capacity of the uint8 array.
    allocator* {.importc: "allocator".}: rcutils_allocator_t ##
                              ##  The allocator used to allocate and free memory for the uint8 array.



proc rcutils_get_zero_initialized_uint8_array*(): rcutils_uint8_array_t {.cdecl,
    importc: "rcutils_get_zero_initialized_uint8_array", header: "uint8_array.h".}
  ##  Return a zero initialized uint8 array struct.
  ##
  ##  \return rcutils_uint8_array_t a zero initialized uint8 array struct
  ##

proc rcutils_uint8_array_init*(uint8_array: ptr rcutils_uint8_array_t;
                              buffer_capacity: csize_t;
                              allocator: ptr rcutils_allocator_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_uint8_array_init", header: "uint8_array.h".}
  ##  Initialize a zero initialized uint8 array struct.
  ##
  ##  This function may leak if the uint8 array struct is already initialized.
  ##  If the capacity is set to 0, no memory is allocated and the internal buffer
  ##  is still NULL.
  ##
  ##  \param[inout] uint8_array a pointer to the to be initialized uint8 array struct
  ##  \param[in] buffer_capacity the size of the memory to allocate for the byte stream
  ##  \param[in] allocator the allocator to use for the memory allocation
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT if any arguments are invalid, or
  ##  \return 'RCUTILS_RET_BAD_ALLOC` if no memory could be allocated correctly
  ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
  ##

proc rcutils_uint8_array_fini*(uint8_array: ptr rcutils_uint8_array_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_uint8_array_fini", header: "uint8_array.h".}
  ##  Finalize a uint8 array struct.
  ##
  ##  Cleans up and deallocates any resources used in a rcutils_uint8_array_t.
  ##  The array passed to this function needs to have been initialized by
  ##  rcutils_uint8_array_init().
  ##  Passing an uninitialized instance to this function leads to undefined
  ##  behavior.
  ##
  ##  \param[in] uint8_array pointer to the rcutils_uint8_array_t to be cleaned up
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT if the uint8_array argument is invalid
  ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
  ##

proc rcutils_uint8_array_resize*(uint8_array: ptr rcutils_uint8_array_t;
                                new_size: csize_t): rcutils_ret_t {.cdecl,
    importc: "rcutils_uint8_array_resize", header: "uint8_array.h".}
  ##  Resize the internal buffer of the uint8 array.
  ##
  ##  The internal buffer of the uint8 array can be resized dynamically if needed.
  ##  If the new size is smaller than the current capacity, then the memory is
  ##  truncated.
  ##  Be aware, that this might deallocate the memory and therefore invalidates any
  ##  pointers to this storage.
  ##
  ##  \param[inout] uint8_array pointer to the instance of rcutils_uint8_array_t which is
  ##  being resized
  ##  \param[in] new_size the new size of the internal buffer
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT if new_size is set to zero
  ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
  ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
  ## 