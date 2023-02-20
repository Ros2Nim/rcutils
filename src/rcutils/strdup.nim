##  Copyright 2017 Open Source Robotics Foundation, Inc.
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
  rcutils.macros, rcutils.macros, rcutils.macros, rcutils.macros,
  rcutils.allocator, rcutils.types.rcutils_ret, rcutils.allocator,
  rcutils.visibility_control, rcutils.visibility_control_macros,
  rcutils.visibility_control_macros, rcutils.visibility_control,
  rcutils.allocator


proc rcutils_strdup*(str: cstring; allocator: allocator_t): cstring {.cdecl,
    importc: "rcutils_strdup", header: "strdup.h".}
  ##
                              ##  Return a duplicated string with an allocator, or null if an error occurs.
                              ##
                              ##  This function is identical to rcutils_strndup() except the length of the
                              ##  c string does not have to be given and therefore the c string must be
                              ##  null terminated.
                              ##
                              ##  \see rcutils_strndup()
                              ##
                              ##  \param[in] str null terminated c string to be duplicated
                              ##  \param[in] allocator the allocator to use for allocation
                              ##  \return duplicated string, or
                              ##  \return `NULL` if there is an error.
                              ##

proc rcutils_strndup*(str: cstring; max_length: csize_t; allocator: allocator_t): cstring {.
    cdecl, importc: "rcutils_strndup", header: "strdup.h".}
  ##
                              ##  Return a duplicated string with an allocator, or null if an error occurs.
                              ##
                              ##  This function can fail and return null if memory cannot be allocated or
                              ##  if the input c string pointer is null.
                              ##  In both cases no error message is set.
                              ##  The returned string should be deallocated using the given allocator when
                              ##  it is no longer needed.
                              ##
                              ##  The max_length given does not include the null terminating character.
                              ##  Therefore a max_length of 0 will still result in a duplicated string, but
                              ##  the string will be an empty string of strlen 0, but it still must be
                              ##  deallocated.
                              ##  All returned strings are null terminated.
                              ##
                              ##  \param[in] str null terminated c string to be duplicated
                              ##  \param[in] max_length maximum length of the string to duplicate
                              ##  \param[in] allocator the allocator to use for allocation
                              ##  \return duplicated string, or
                              ##  \return `NULL` if there is an error.
                              ## 