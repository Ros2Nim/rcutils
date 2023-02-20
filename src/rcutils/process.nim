##  Copyright 2019 Open Source Robotics Foundation, Inc.
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


proc rcutils_get_pid*(): cint {.cdecl, importc: "rcutils_get_pid",
                                header: "process.h".}
  ##
                              ##  Retrieve the current process ID.
                              ##
                              ##  This function returns the current process ID, and is always successful.
                              ##
                              ##  This function is thread-safe.
                              ##
                              ##  \return The current process ID.
                              ##

proc rcutils_get_executable_name*(allocator: allocator_t): cstring {.cdecl,
    importc: "rcutils_get_executable_name", header: "process.h".}
  ##
                              ##  Retrieve the current executable name.
                              ##
                              ##  This function portably retrieves the current program name and returns
                              ##  a copy of it.
                              ##  It is up to the caller to free the memory.
                              ##
                              ##  This function is thread-safe.
                              ##
                              ##  \param[in] allocator the allocator to use
                              ##  \return The program name on success, or
                              ##  \return NULL on failure.
                              ## 