const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/snprintf.h" .}
else:
  {.pragma: clib, dynlib: "" & rcutilsDynlib.}

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
  ./macros,                 ##  clang -E -dI
  ./visibility_control,     ##  clang -E -dI
  ./visibility_control_macros


proc rcutils_snprintf*(buffer: cstring; buffer_size: csize_t; format: cstring): cint {.
    varargs, cdecl, importc: "rcutils_snprintf", clib.}
  ##
                              ##  Format a string.
                              ##
                              ##  This function just wraps snprintf() as defined in C11 in a portable way.
                              ##
                              ##  On Windows this defaults to the _TRUNCATE behavior of _snprintf_s(), but
                              ##  only returns -1 if errno is not 0.
                              ##  Unlike _snprintf_s() which returns -1 when truncation occurs, this function
                              ##  behaves like snprintf() (http://en.cppreference.com/w/cpp/io/c/fprintf):
                              ##
                              ##  > Number of characters written if successful or negative value if an error
                              ##  > occurred.
                              ##  > If the resulting string gets truncated due to buf_size limit, function
                              ##  > returns the total number of characters (not including the terminating
                              ##  > null-byte) which would have been written, if the limit was not imposed.
                              ##
                              ##  If `NULL` and `0` are given for buffer and buffer_size respectively, the
                              ##  size of the string that would be generated is returned.
                              ##  Either snprintf() or _vscprintf() is used to calculate this value.
                              ##
                              ##  \see snprintf()
                              ##  \see _snprintf_s()
                              ##  \return the number of bytes that would have been written given enough space, or
                              ##  \return a negative number if there is an error, but unlike _snprintf_s(),
                              ##    -1 is not returned if there is truncation.
                              ##
  ##  @cond Doxygen_Suppress

proc rcutils_vsnprintf*(buffer: cstring; buffer_size: csize_t; format: cstring;
                        args: varargs[pointer]): cint {.cdecl,
    importc: "rcutils_vsnprintf", clib.}
  ##  Format a string with va_list for arguments, see rcutils_snprintf().