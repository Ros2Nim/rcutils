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
  rcutils.types, rcutils.types.array_list, rcutils.types.array_list,
  rcutils.allocator, rcutils.allocator, rcutils.allocator, rcutils.macros,
  rcutils.macros, rcutils.macros, rcutils.macros, rcutils.macros,
  rcutils.allocator, rcutils.types.rcutils_ret, rcutils.allocator,
  rcutils.visibility_control, rcutils.visibility_control_macros,
  rcutils.visibility_control_macros, rcutils.visibility_control,
  rcutils.allocator, rcutils.types.array_list, rcutils.types,
  rcutils.types.char_array, rcutils.types.char_array, rcutils.types,
  rcutils.types.hash_map, rcutils.types.hash_map, rcutils.types,
  rcutils.types.string_array, rcutils.types.string_array,
  rcutils.error_handling, rcutils.error_handling, rcutils.error_handling,
  rcutils.error_handling, rcutils.error_handling, rcutils.error_handling,
  rcutils.error_handling, rcutils.snprintf, rcutils.snprintf,
  rcutils.error_handling, rcutils.testing.fault_injection,
  rcutils.testing.fault_injection, rcutils.testing.fault_injection,
  rcutils.error_handling, rcutils.error_handling, rcutils.error_handling,
  rcutils.error_handling, rcutils.types.string_array, rcutils.qsort,
  rcutils.qsort, rcutils.types.string_array, rcutils.types,
  rcutils.types.string_map, rcutils.types.string_map, rcutils.types,
  rcutils.types.uint8_array, rcutils.types.uint8_array, rcutils.types


proc rcutils_find*(str: cstring; delimiter: char): csize_t {.cdecl,
    importc: "rcutils_find", header: "find.h".}
  ##  Return the first index of a character in a string.
                                               ##
                                               ##  Search in a string for the first occurence of a delimiter.
                                               ##
                                               ##  \param[in] str null terminated c string to search
                                               ##  \param[in] delimiter the character to search for
                                               ##  \return the index of the first occurence of the delimiter if found, or
                                               ##  \return `SIZE_MAX` for invalid arguments, or
                                               ##  \return `SIZE_MAX` if the delimiter is not found.
                                               ##

proc rcutils_findn*(str: cstring; delimiter: char; string_length: csize_t): csize_t {.
    cdecl, importc: "rcutils_findn", header: "find.h".}
  ##
                              ##  Return the first index of a character in a string of specified length.
                              ##
                              ##  Identical to rcutils_find_first() but without relying on the string to be a
                              ##  null terminated c string.
                              ##
                              ##  \param[in] str string to search
                              ##  \param[in] delimiter the character to search for
                              ##  \param[in] string_length length of the string to search
                              ##  \return the index of the first occurence of the delimiter if found, or
                              ##  \return `SIZE_MAX` for invalid arguments, or
                              ##  \return `SIZE_MAX` if the delimiter is not found.
                              ##

proc rcutils_find_last*(str: cstring; delimiter: char): csize_t {.cdecl,
    importc: "rcutils_find_last", header: "find.h".}
  ##
                              ##  Return the last index of a character in a string.
                              ##
                              ##  Search in a string for the last occurence of a delimiter.
                              ##
                              ##  \param[in] str null terminated c string to search
                              ##  \param[in] delimiter the character to search for
                              ##  \return the index of the last occurence of the delimiter if found, or
                              ##  \return `SIZE_MAX` for invalid arguments, or
                              ##  \return `SIZE_MAX` if the delimiter is not found.
                              ##

proc rcutils_find_lastn*(str: cstring; delimiter: char; string_length: csize_t): csize_t {.
    cdecl, importc: "rcutils_find_lastn", header: "find.h".}
  ##
                              ##  Return the last index of a character in a string of specifed length.
                              ##
                              ##  Identical to rcutils_find_last() but without relying on the string to be a
                              ##  null terminated c string.
                              ##
                              ##  \param[in] str string to search
                              ##  \param[in] delimiter the character to search for
                              ##  \param[in] string_length length of the string to search
                              ##  \return the index of the last occurence of the delimiter if found, or
                              ##  \return `SIZE_MAX` for invalid arguments, or
                              ##  \return `SIZE_MAX` if the delimiter is not found.
                              ## 