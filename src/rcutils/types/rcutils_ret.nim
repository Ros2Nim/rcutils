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

type

  rcutils_ret_t* = cint      ##  The type that holds a return value for an rcutils operation.

const
  RCUTILS_RET_OK* = 0        ##  Successful operation.
  RCUTILS_RET_WARN* = 1      ##  Operation produced a warning.
  RCUTILS_RET_ERROR* = 2     ##  Generic failure in operation.
  RCUTILS_RET_BAD_ALLOC* = 10 ##  Failed to allocate memory return code.
  RCUTILS_RET_INVALID_ARGUMENT* = 11 ##  Invalid argument return code.
  RCUTILS_RET_NOT_ENOUGH_SPACE* = 12 ##  Not enough storage to do operation.
  RCUTILS_RET_NOT_INITIALIZED* = 13 ##  Resource is not initialized
  RCUTILS_RET_NOT_FOUND* = 14 ##  Resource for request not found
  RCUTILS_RET_STRING_MAP_ALREADY_INIT* = 30 ##  Given string map was either already initialized or was not zero initialized.
  RCUTILS_RET_STRING_MAP_INVALID* = 31 ##  Given string map is invalid, perhaps not initialized yet.
  RCUTILS_RET_STRING_KEY_NOT_FOUND* = 32 ##  Given key not found in given string map.
  RCUTILS_RET_LOGGING_SEVERITY_MAP_INVALID* = 40 ##  Internal severity map for logger thresholds is invalid.
  RCUTILS_RET_LOGGING_SEVERITY_STRING_INVALID* = 41 ##
                              ##  String representation of a severity is invalid.
  RCUTILS_RET_HASH_MAP_NO_MORE_ENTRIES* = 50 ##  There are no more entires beyond the last one in the map
