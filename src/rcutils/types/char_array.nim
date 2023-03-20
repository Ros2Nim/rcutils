##  #pragma c2nim cdecl

import rcutils_ret
import ../allocator

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


type

  rcutils_char_array_t* {.importc: "rcutils_char_array_t",
                          header: "rcutils/char_array.h", bycopy.} = object ##
                              ##  The structure holding the metadata for a char array.
    buffer* {.importc: "buffer".}: cstring ##  A pointer to the allocated memory for this char array.
    owns_buffer* {.importc: "owns_buffer".}: bool ##
                                                  ##  if this is true, we may safely free/realloc the buffer as needed;
                                                  ##  otherwise we will leave the buffer alone and alloc new memory if
                                                  ##  more space is needed
                                                  ##
    buffer_length* {.importc: "buffer_length".}: csize_t ##
                              ##  The length of the data stored in the buffer pointer.
    buffer_capacity* {.importc: "buffer_capacity".}: csize_t ##
                              ##  The maximum capacity of the buffer pointer.
    allocator* {.importc: "allocator".}: rcutils_allocator_t ##
                              ##  The allocator used to allocate and free the data in the pointer.




proc rcutils_get_zero_initialized_char_array*(): rcutils_char_array_t {.
    importc: "rcutils_get_zero_initialized_char_array",
    header: "rcutils/char_array.h".}
  ##  Return a zero initialized char array struct.
                                    ##
                                    ##  \return rcutils_char_array_t a zero initialized char array struct
                                    ##

proc rcutils_char_array_init*(char_array: ptr rcutils_char_array_t;
                              buffer_capacity: csize_t;
                              allocator: ptr rcutils_allocator_t): rcutils_ret_t {.
    importc: "rcutils_char_array_init", header: "rcutils/char_array.h".}
  ##
                              ##  Initialize a zero initialized char array struct.
                              ##
                              ##  This function may leak if the char array struct is already
                              ##  pre-initialized.
                              ##  If the capacity is set to 0, no memory is allocated and the internal buffer
                              ##  is still NULL.
                              ##
                              ##  \param[in] char_array a pointer to the to be initialized char array struct
                              ##  \param[in] buffer_capacity the size of the memory to allocate for the byte stream
                              ##  \param[in] allocator the allocator to use for the memory allocation
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT if any arguments are invalid, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if no memory could be allocated correctly
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_fini*(char_array: ptr rcutils_char_array_t): rcutils_ret_t {.
    importc: "rcutils_char_array_fini", header: "rcutils/char_array.h".}
  ##
                              ##  Finalize a char array struct.
                              ##
                              ##  Cleans up and deallocates any resources owned by rcutils_char_array_t.
                              ##  The array passed to this function needs to have been initialized by
                              ##  rcutils_char_array_init().
                              ##  If .owns_buffer is false, this function has no effect because that
                              ##  implies that the char_array does not own the internal buffer.
                              ##  Passing an uninitialized instance to this function leads to undefined
                              ##  behavior.
                              ##
                              ##  \param[in] char_array pointer to the rcutils_char_array_t to be cleaned up
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT if the char_array argument is invalid
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_resize*(char_array: ptr rcutils_char_array_t;
                                new_size: csize_t): rcutils_ret_t {.
    importc: "rcutils_char_array_resize", header: "rcutils/char_array.h".}
  ##
                              ##  Resize the internal buffer of the char array.
                              ##
                              ##  The internal buffer of the char array can be resized dynamically if needed.
                              ##  If the new size is smaller than the current capacity, then the memory is
                              ##  truncated.
                              ##  Be aware, that this will deallocate the memory and therefore invalidates any
                              ##  pointers to this storage.
                              ##  If the new size is larger, new memory is getting allocated and the existing
                              ##  content is copied over.
                              ##  Note that if the array doesn't own the current buffer the function just
                              ##  allocates a new block of memory and copies the contents of the old buffer
                              ##  instead of resizing the existing buffer.
                              ##
                              ##  \param[in] char_array pointer to the instance of rcutils_char_array_t which is being resized
                              ##  \param[in] new_size the new size of the internal buffer
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT if new_size is set to zero
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_expand_as_needed*(char_array: ptr rcutils_char_array_t;
    new_size: csize_t): rcutils_ret_t {.importc: "rcutils_char_array_expand_as_needed",
                                        header: "rcutils/char_array.h".}
  ##
                              ##  Expand the internal buffer of the char array.
                              ##
                              ##  This function is equivalent to `rcutils_char_array_resize` except that it resizes
                              ##  the internal buffer only when it is not big enough.
                              ##  If the buffer is already big enough for `new_size`, it returns `RCUTILS_RET_OK` without
                              ##  doing anything.
                              ##
                              ##  \param[inout] char_array pointer to the instance of rcutils_char_array_t which is being resized
                              ##  \param[in] new_size the new size of the internal buffer
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_vsprintf*(char_array: ptr rcutils_char_array_t;
                                  format: cstring; args: varargs[pointer]): rcutils_ret_t {.
    importc: "rcutils_char_array_vsprintf", header: "rcutils/char_array.h".}
  ##
                              ##  Produce output according to format and args.
                              ##
                              ##  This function is equivalent to `vsprintf(char_array->buffer, format, args)`
                              ##  except that the buffer grows as needed so a user doesn't have to deal with
                              ##  memory management.
                              ##  The `va_list args` will be cloned before being used, so a user can safely
                              ##  use it again after calling this function.
                              ##
                              ##  \param[inout] char_array pointer to the instance of rcutils_char_array_t which is being
                              ##  written to
                              ##  \param[in] format the format string used by the underlying `vsnprintf`
                              ##  \param[in] args the `va_list` used by the underlying `vsnprintf`
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_strncat*(char_array: ptr rcutils_char_array_t;
                                 src: cstring; n: csize_t): rcutils_ret_t {.
    importc: "rcutils_char_array_strncat", header: "rcutils/char_array.h".}
  ##
                              ##  Append a string (or part of it) to the string in buffer.
                              ##
                              ##  This function treats the internal buffer as a string and appends the src string to it.
                              ##  If src is longer than n, n bytes will be used and an extra null byte will be appended.
                              ##  It is virtually equivalent to `strncat(char_array->buffer, src, n)` except that the buffer
                              ##  grows as needed so a user doesn't have to deal with memory management.
                              ##
                              ##  \param[inout] char_array pointer to the instance of rcutils_char_array_t which is being appended to
                              ##  \param[in] src the string to be appended to the end of the string in buffer
                              ##  \param[in] n it uses at most n bytes from the src string
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_strcat*(char_array: ptr rcutils_char_array_t;
                                src: cstring): rcutils_ret_t {.
    importc: "rcutils_char_array_strcat", header: "rcutils/char_array.h".}
  ##
                              ##  Append a string to the string in buffer.
                              ##
                              ##  This function treats the internal buffer as a string and appends the src string to it.
                              ##  It is virtually equivalent to `strcat(char_array->buffer, src)` except that the buffer
                              ##  grows as needed. That is to say, a user can safely use it without doing calculation or
                              ##  checks on the sizes of the src and buffer.
                              ##
                              ##  \param[inout] char_array pointer to the instance of rcutils_char_array_t which is being
                              ##  appended to
                              ##  \param[in] src the string to be appended to the end of the string in buffer
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_memcpy*(char_array: ptr rcutils_char_array_t;
                                src: cstring; n: csize_t): rcutils_ret_t {.
    importc: "rcutils_char_array_memcpy", header: "rcutils/char_array.h".}
  ##
                              ##  Copy memory to buffer.
                              ##
                              ##  This function is equivalent to `memcpy(char_array->buffer, src, n)` except that the buffer
                              ##  grows as needed so a user doesn't have to worry about overflow.
                              ##
                              ##  \param[inout] char_array pointer to the instance of rcutils_char_array_t which is being resized
                              ##  \param[in] src the memory to be copied from
                              ##  \param[in] n a total of n bytes will be copied
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ##

proc rcutils_char_array_strcpy*(char_array: ptr rcutils_char_array_t;
                                src: cstring): rcutils_ret_t {.
    importc: "rcutils_char_array_strcpy", header: "rcutils/char_array.h".}
  ##
                              ##  Copy a string to buffer.
                              ##
                              ##  This function is equivalent to `strcpy(char_array->buffer, src)` except that the buffer
                              ##  grows as needed so that `src` will fit without overflow.
                              ##
                              ##  \param[inout] char_array pointer to the instance of rcutils_char_array_t which is being
                              ##  copied to
                              ##  \param[in] src the string to be copied from
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation failed, or
                              ##  \return #RCUTILS_RET_ERROR if an unexpected error occurs.
                              ## 