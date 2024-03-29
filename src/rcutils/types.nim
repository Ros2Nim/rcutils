const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/types.h" .}
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

import
  ./types/array_list,       ##  clang -E -dI
  ./allocator, ./macros, ./types/rcutils_ret, ./visibility_control,
  ./visibility_control_macros, ./types/char_array, ##
                              ##  clang -E -dI
  ./types/hash_map,         ##  clang -E -dI
  ./types/string_array,     ##  clang -E -dI
  ./error_handling, ./snprintf, ./testing/fault_injection, ./qsort, ./types/string_map, ##
                              ##  clang -E -dI
  ./types/uint8_array

##  clang -E -dI