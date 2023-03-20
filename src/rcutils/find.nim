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
  ./types, ./types/array_list, ./allocator, ./macros, ./types/rcutils_ret,
  ./visibility_control, ./visibility_control_macros, ./types/char_array,
  ./types/hash_map, ./types/string_array, ./error_handling, ./snprintf,
  ./testing/fault_injection, ./qsort, ./types/string_map, ./types/uint8_array


proc rcutils_find*(str: cstring; delimiter: char): csize_t {.
    importc: "rcutils_find", header: "rcutils/find.h".}
  ##
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
    importc: "rcutils_findn", header: "rcutils/find.h".}
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

proc rcutils_find_last*(str: cstring; delimiter: char): csize_t {.
    importc: "rcutils_find_last", header: "rcutils/find.h".}
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
    importc: "rcutils_find_lastn", header: "rcutils/find.h".}
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