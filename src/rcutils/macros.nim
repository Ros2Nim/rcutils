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
##  @file

##  A macro to make the compiler warn when the return value of a function is not used.

##  \cond Doxygen_Suppress
##  Apple OS's
##  macOS

##  A macro to mark an argument or variable as unused.

##  @endcond
##  Macro to annotate printf-like functions which are relying on a format string and a variable
##  number of arguments.
##
##  This enables GCC to emit warnings if dangerous patterns are detected.
##  See GCC documentation for details:
##  https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
##
##  For the following function:
##  ```
##  int snprintf(char *str, size_t size, const char *format, ...);
##               ^^^^^^^^^  ^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^  ^^^
##               ARG 1      ARG 2        ARG 3               ARG 4
##                                       format string       first optional argument
##  ```
##  format_string_index value would be 3, first_to_check_index value would be 4.
##
##  IMPORTANT: the first argument has an index of ONE (not zero!).
##
##  \param[in] format_string_index index of the format string passed to the function
##  \param[in] first_to_check_index index of the first "optional argument"
##

##  Macro to declare deprecation in the platform appropriate manner.

##  Macro to declare deprecation in the platform appropriate manner with a message.

##  Provide the compiler with branch prediction information
##
##  \def RCUTILS_LIKELY
##  Instruct the compiler to optimize for the case where the argument equals 1.
##

##
##  \def RCUTILS_UNLIKELY
##  Instruct the compiler to optimize for the case where the argument equals 0.
##

const
  RCUTILS_HAS_NONNULL* = 1   ##  Provide the compiler a hint about an argument being nonnull when possible.
