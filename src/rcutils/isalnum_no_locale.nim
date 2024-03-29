converter charToNum*(c: char): int = c.int
const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/isalnum_no_locale.h" .}
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


proc rcutils_isalnum_no_locale*(c: char): bool {.inline, cdecl,
    importc: "rcutils_isalnum_no_locale".}
  ##  Custom isalnum() which is not affected by locale.