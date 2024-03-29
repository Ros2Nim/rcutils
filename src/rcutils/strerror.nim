const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/strerror.h" .}
else:
  {.pragma: clib, dynlib: "" & rcutilsDynlib.}

##  Copyright 2020 Open Source Robotics Foundation, Inc.
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
  ./visibility_control,     ##  clang -E -dI
  ./visibility_control_macros


proc rcutils_strerror*(buffer: cstring; buffer_length: csize_t) {.cdecl,
    importc: "rcutils_strerror", clib.}
  ##  Retrieve the string corresponding to the last system error.
                                       ##
                                       ##  This function retrieves the value of errno, and calls the system-specific
                                       ##  equivalent of `strerror` on it, storing the output in the provided buffer.
                                       ##  If the error message is longer than the buffer, it will be truncated.
                                       ##  The memory for the c-string buffer that is passed in must be managed by the
                                       ##  caller.
                                       ##
                                       ##  This function is thread-safe.
                                       ##
                                       ##  \param[inout] buffer The buffer in which to store the data
                                       ##  \param[in] buffer_length the maximum length of the buffer
                                       ## 