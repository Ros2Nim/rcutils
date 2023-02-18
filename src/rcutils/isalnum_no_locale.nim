##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim header

##  #pragma c2nim importc

##  #pragma c2nim render nobody

converter charToNum*(c: char): int = c.int

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


proc rcutils_isalnum_no_locale*(c: char): bool {.inline.} =
  ##  Custom isalnum() which is not affected by locale.
  ##  if in '0', ..., '9', then ok
  if c >= 0x30 and c <= 0x39:
    return true
  if c >= 0x41 and c <= 0x5a:
    return true
  if c >= 0x61 and c <= 0x7a:
    return true
  return false
