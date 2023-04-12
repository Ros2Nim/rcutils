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

import
  ./allocator,              ##  clang -E -dI
  ./macros, ./types/rcutils_ret, ./visibility_control,
  ./visibility_control_macros

##  Return a newly allocated string, created with a format string.
##
##  This function is identical to rcutils_format_string_limit() except it has an
##  implicit limit of 2048.
##  For longer format strings, see rcutils_format_string_limit().
##


proc rcutils_format_string_limit*(allocator: rcutils_allocator_t;
                                  limit: csize_t; format_string: cstring): cstring {.
    varargs, cdecl, importc: "rcutils_format_string_limit",
    header: "rcutils/format_string.h".}
  ##  Return a newly allocated string, created with a format string up to a limit.
                                       ##
                                       ##  This function uses snprintf_s to determine the length of the resulting
                                       ##  string and allocates storage for the resulting string, formats it, and
                                       ##  then returns the result.
                                       ##
                                       ##  This function can fail and therefore return null if the format_string is
                                       ##  null or if memory allocation fails or if snprintf_s fails.
                                       ##  An error message is not set in any case.
                                       ##
                                       ##  Output strings that would be longer than the given limit are truncated.
                                       ##
                                       ##  All returned strings are null terminated.
                                       ##
                                       ##  The format string is passed to snprintf_s(), see its documentation for
                                       ##  how to use the format string.
                                       ##
                                       ##  The returned string must be deallocated using the same allocator given once
                                       ##  it is no longer needed.
                                       ##
                                       ##  \see rcutils_snprintf()
                                       ##
                                       ##  \param[in] allocator the allocator to use for allocation
                                       ##  \param[in] limit maximum length of the output string
                                       ##  \param[in] format_string format of the output, must be null terminated
                                       ##  \return The newly allocated and format output string, or
                                       ##  \return `NULL` if there was an error.
                                       ##
  ##  @cond Doxygen_Suppress