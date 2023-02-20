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
  ./allocator, ./allocator, ./allocator, ./macros, ./macros, ./macros, ./macros,
  ./macros, ./allocator, ./types/rcutils_ret, ./allocator, ./visibility_control,
  ./visibility_control_macros, ./visibility_control_macros,
  ./visibility_control, ./allocator, ./types, ./types/array_list,
  ./types/array_list, ./types, ./types/char_array, ./types/char_array, ./types,
  ./types/hash_map, ./types/hash_map, ./types, ./types/string_array,
  ./types/string_array, ./error_handling, ./error_handling, ./error_handling,
  ./error_handling, ./error_handling, ./error_handling, ./error_handling,
  ./snprintf, ./snprintf, ./error_handling, ./testing/fault_injection,
  ./testing/fault_injection, ./testing/fault_injection, ./error_handling,
  ./error_handling, ./error_handling, ./error_handling, ./types/string_array,
  ./qsort, ./qsort, ./types/string_array, ./types, ./types/string_map,
  ./types/string_map, ./types, ./types/uint8_array, ./types/uint8_array, ./types


proc rcutils_split*(str: cstring; delimiter: char; allocator: allocator_t;
                    string_array: ptr string_array_t): ret_t {.cdecl,
    importc: "rcutils_split", header: "split.h".}
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

proc rcutils_split_last*(str: cstring; delimiter: char; allocator: allocator_t;
                         string_array: ptr string_array_t): ret_t {.cdecl,
    importc: "rcutils_split_last", header: "split.h".}
  ##
                              ##  Split a given string on the last occurrence of the specified delimiter
                              ##
                              ##  \param[in] str string to split
                              ##  \param[in] delimiter on where to split
                              ##  \param[in] allocator for allocating new memory for the output array
                              ##  \param[out] string_array with the split tokens
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs
                              ## 