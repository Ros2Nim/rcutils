const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/split.h" .}
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
  ./allocator,              ##  clang -E -dI
  ./macros, ./types/rcutils_ret, ./visibility_control,
  ./visibility_control_macros, ./types, ##  clang -E -dI
  ./types/array_list, ./types/char_array, ./types/hash_map,
  ./types/string_array, ./error_handling, ./snprintf, ./testing/fault_injection,
  ./qsort, ./types/string_map, ./types/uint8_array


proc rcutils_split*(str: cstring; delimiter: char;
                    allocator: rcutils_allocator_t;
                    string_array: ptr rcutils_string_array_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_split", clib.}
  ##  Split a given string with the specified delimiter
                                           ##
                                           ##  \param[in] str string to split
                                           ##  \param[in] delimiter on where to split
                                           ##  \param[in] allocator for allocating new memory for the output array
                                           ##  \param[out] string_array with the split tokens
                                           ##  \return #RCUTILS_RET_OK if successful, or
                                           ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                                           ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
                                           ##  \return #RCUTILS_RET_ERROR if an unknown error occurs
                                           ##

proc rcutils_split_last*(str: cstring; delimiter: char;
                         allocator: rcutils_allocator_t;
                         string_array: ptr rcutils_string_array_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_split_last", clib.}
  ##  Split a given string on the last occurrence of the specified delimiter
                                                ##
                                                ##  \param[in] str string to split
                                                ##  \param[in] delimiter on where to split
                                                ##  \param[in] allocator for allocating new memory for the output array
                                                ##  \param[out] string_array with the split tokens
                                                ##  \return #RCUTILS_RET_OK if successful, or
                                                ##  \return #RCUTILS_RET_ERROR if an unknown error occurs
                                                ## 