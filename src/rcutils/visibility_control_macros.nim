const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/visibility_control_macros.h" .}
else:
  {.pragma: clib, dynlib: "" & rcutilsDynlib.}

##  Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

##  Defines macros to express whether a symbol is localed, imported, or exported
##
##  Those macros are compatible with GCC, clang, and Microsoft Visual C++. They
##  can be used to enforce which symbols of a library are publicly accessible.
##
##  RCUTILS_IMPORT, RCUTILS_EXPORT, and RCUTILS_LOCAL are respectively declaring
##  an imported, exported, or local symbol.
##  RCUTILS_LOCAL can be used directly. However, RCUTILS_IMPORT, and
##  RCUTILS_EXPORT may not be used directly. Every project need to provide
##  an additional header called `visibility_macros.h` containing:
##
##  #ifdef <project>_BUILDING_DLL
##  # define <project>_PUBLIC RCUTILS_EXPORT
##  #else
##  # define <project>_PUBLIC RCUTILS_IMPORT
##  #endif // !<project>_BUILDING_DLL
##  #define <project>_LOCAL RCUTILS_LOCAL
##
##  ...where "<project>" has been replaced by the project name, such as
##  "MY_PROJECT".
##  Your project CMakeLists.txt should also contain the following statement:
##
##  target_compile_definitions(<your library> PRIVATE "<project>_BUILDING_DLL")
##
##  A public (exported) class should then be tagged as <project>_PUBLIC, whereas
##  a non-public class should be tagged with <project>_LOCAL.
##
##  See GCC documentation: https://gcc.gnu.org/wiki/Visibility
##  On Linux, use the GCC syntax. This syntax is understood by other compilers
##  such as clang, icpc, and xlc++.
