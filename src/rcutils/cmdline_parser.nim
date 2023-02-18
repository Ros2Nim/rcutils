##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim header

##  #pragma c2nim importc

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
  ./visibility_control, ./visibility_control_macros, ./visibility_control_macros,
  ./visibility_control


proc rcutils_cli_option_exist*(begin: cstringArray; `end`: cstringArray;
                              option: cstring): bool {.
    importc: "rcutils_cli_option_exist", header: "cmdline_parser.h".}
  ##  Return `true` if the option is defined in the command line arguments or `false` otherwise.
  ##
  ##  \param[in] begin first element to check in the array
  ##  \param[in] end last element to check in the array
  ##  \param[in] option string to find in the array of arguments
  ##  \return `true` if the option exists, or
  ##  \return `false` otherwise.
  ##

proc rcutils_cli_get_option*(begin: cstringArray; `end`: cstringArray;
                            option: cstring): cstring {.
    importc: "rcutils_cli_get_option", header: "cmdline_parser.h".}
  ##  Return the value for a specific option of the command line arguments.
  ##
  ##  \param[in] begin first element to check in the array
  ##  \param[in] end last element to check in the array
  ##  \param[in] option string to find in the array of arguments
  ##  \return the value for a specific option of the command line arguments, or
  ##  \return `NULL` if the option doesn't exist.
  ## 