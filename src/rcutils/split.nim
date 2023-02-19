##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim render nobody

##  #pragma c2nim render nobody

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
  rcutils.macros, rcutils.macros, rcutils.macros, rcutils.macros, rcutils.allocator,
  rcutils.types.rcutils_ret, rcutils.allocator, rcutils.visibility_control,
  rcutils.visibility_control_macros, rcutils.visibility_control_macros,
  rcutils.visibility_control, rcutils.allocator, rcutils.types,
  rcutils.types.array_list, rcutils.types.array_list, rcutils.types,
  rcutils.types.char_array, rcutils.types.char_array, rcutils.types,
  rcutils.types.hash_map, rcutils.types.hash_map, rcutils.types,
  rcutils.types.string_array, rcutils.types.string_array, rcutils.error_handling,
  rcutils.error_handling, rcutils.error_handling, rcutils.error_handling,
  rcutils.error_handling, rcutils.error_handling, rcutils.error_handling,
  rcutils.snprintf, rcutils.snprintf, rcutils.error_handling,
  rcutils.testing.fault_injection, rcutils.testing.fault_injection,
  rcutils.testing.fault_injection, rcutils.error_handling, rcutils.error_handling,
  rcutils.error_handling, rcutils.error_handling, rcutils.types.string_array,
  rcutils.qsort, rcutils.qsort, rcutils.types.string_array, rcutils.types,
  rcutils.types.string_map, rcutils.types.string_map, rcutils.types,
  rcutils.types.uint8_array, rcutils.types.uint8_array, rcutils.types


proc rcutils_split*(str: cstring; delimiter: char; allocator: rcutils_allocator_t;
                   string_array: ptr rcutils_string_array_t): rcutils_ret_t {.cdecl,
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

proc rcutils_split_last*(str: cstring; delimiter: char;
                        allocator: rcutils_allocator_t;
                        string_array: ptr rcutils_string_array_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_split_last", header: "split.h".}
  ##  Split a given string on the last occurrence of the specified delimiter
  ##
  ##  \param[in] str string to split
  ##  \param[in] delimiter on where to split
  ##  \param[in] allocator for allocating new memory for the output array
  ##  \param[out] string_array with the split tokens
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs
  ## 