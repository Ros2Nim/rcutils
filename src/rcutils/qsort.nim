##  Copyright 2020 Open Source Robotics Foundation, Inc.
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
  ./macros, ./macros, ./macros, ./macros, ./macros, ./types/rcutils_ret,
  ./visibility_control, ./visibility_control_macros,
  ./visibility_control_macros, ./visibility_control


proc rcutils_qsort*(`ptr`: pointer; count: csize_t; size: csize_t;
                    comp: proc (a1: pointer; a2: pointer): cint {.cdecl.}): rcutils_ret_t {.
    cdecl, importc: "rcutils_qsort", header: "qsort.h".}
  ##
                              ##  Interface to qsort with rcutils-style argument validation.
                              ##
                              ##  This function changes the order of the elements in the array so that they
                              ##  are in ascending order according to the given comparison function.
                              ##
                              ##  This function is thread-safe.
                              ##
                              ##  \param[inout] ptr object whose elements should be sorted.
                              ##  \param[in] count number of elements present in the object.
                              ##  \param[in] size size of each element, in bytes.
                              ##  \param[in] comp function used to compare two elements.
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ## 