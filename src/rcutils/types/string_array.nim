import rcutils_ret
import ../allocator
const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/string_array.h" .}
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


type

  rcutils_string_array_t* {.importc: "rcutils_string_array_t",
                            header: "rcutils/string_array.h", bycopy.} = object ##
                              ##  The structure holding the metadata for a string array.
    size* {.importc: "size".}: csize_t ##  The number of strings that can be stored in the string array.
    data* {.importc: "data".}: cstringArray ##  The allocated memory for the string array.
    allocator* {.importc: "allocator".}: rcutils_allocator_t ##
                              ##  The allocator used to allocate and free memory for the string array.




proc rcutils_get_zero_initialized_string_array*(): rcutils_string_array_t {.
    cdecl, importc: "rcutils_get_zero_initialized_string_array", clib.}
  ##
                              ##  Return an empty string array struct.
                              ##
                              ##  This function returns an empty and zero initialized string array struct.
                              ##  Calling rcutils_string_array_fini() on any non-initialized instance leads
                              ##  to undefined behavior.
                              ##  Every instance of string_array_t has to either be zero_initialized with this
                              ##  function or manually allocated.
                              ##
                              ##  Example:
                              ##
                              ##  ```c
                              ##  rcutils_string_array_t foo;
                              ##  rcutils_string_array_fini(&foo); // undefined behavior!
                              ##
                              ##  rcutils_string_array_t bar = rcutils_get_zero_initialized_string_array();
                              ##  rcutils_string_array_fini(&bar); // ok
                              ##  ```
                              ##

proc rcutils_string_array_init*(string_array: ptr rcutils_string_array_t;
                                size: csize_t;
                                allocator: ptr rcutils_allocator_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_string_array_init", clib.}
  ##
                              ##  Initialize a string array with a given size.
                              ##
                              ##  This function will initialize a given, zero initialized, string array to
                              ##  a given size.
                              ##
                              ##  Note that putting a string into the array gives owenship to the array.
                              ##
                              ##  Example:
                              ##
                              ##  ```c
                              ##  rcutils_allocator_t allocator = rcutils_get_default_allocator();
                              ##  rcutils_string_array_t string_array = rcutils_get_zero_initialized_string_array();
                              ##  rcutils_ret_t ret = rcutils_string_array_init(&string_array, 2, &allocator);
                              ##  if (ret != RCUTILS_RET_OK) {
                              ##    // ... error handling
                              ##  }
                              ##  string_array.data[0] = rcutils_strdup("Hello", &allocator);
                              ##  string_array.data[1] = rcutils_strdup("World", &allocator);
                              ##  ret = rcutils_string_array_fini(&string_array);
                              ##  ```
                              ##
                              ##  \param[inout] string_array object to be initialized
                              ##  \param[in] size the size the array should be
                              ##  \param[in] allocator to be used to allocate and deallocate memory
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_string_array_fini*(string_array: ptr rcutils_string_array_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_string_array_fini", clib.}
  ##
                              ##  Finalize a string array, reclaiming all resources.
                              ##
                              ##  This function reclaims any memory owned by the string array, including the
                              ##  strings it references.
                              ##
                              ##  The allocator used to initialize the string array is used to deallocate each
                              ##  string in the array and the array of strings itself.
                              ##
                              ##  \param[inout] string_array object to be finalized
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_string_array_cmp*(lhs: ptr rcutils_string_array_t;
                               rhs: ptr rcutils_string_array_t; res: ptr cint): rcutils_ret_t {.
    cdecl, importc: "rcutils_string_array_cmp", clib.}
  ##
                              ##  Compare two string arrays.
                              ##
                              ##  The two string arrays are compared according to lexicographical order.
                              ##
                              ##  \param[in] lhs The first string array.
                              ##  \param[in] rhs The second string array.
                              ##  \param[out] res Negative value if `lhs` appears before `rhs` in lexicographical order.
                              ##    Zero if `lhs` and `rhs` are equal.
                              ##    Positive value if `lhs` appears after `rhs` in lexographical order.
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT if any argument is `NULL, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT if `lhs->data` or `rhs->data` is `NULL, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_string_array_resize*(string_array: ptr rcutils_string_array_t;
                                  new_size: csize_t): rcutils_ret_t {.cdecl,
    importc: "rcutils_string_array_resize", clib.}
  ##  Resize a string array, reclaiming removed resources.
                                                  ##
                                                  ##  This function changes the size of an existing string array.
                                                  ##  If the new size is larger, new entries are added to the end of the array and
                                                  ##  are zero- initialized.
                                                  ##  If the new size is smaller, entries are removed from the end of the array
                                                  ##  and their resources reclaimed.
                                                  ##
                                                  ##  \par Note:
                                                  ##  Resizing to 0 is not a substitute for calling ::rcutils_string_array_fini.
                                                  ##
                                                  ##  \par Note:
                                                  ##  If this function fails, \p string_array remains unchanged and should still
                                                  ##  be reclaimed with ::rcutils_string_array_fini.
                                                  ##
                                                  ##  \param[inout] string_array object to be resized.
                                                  ##  \param[in] new_size the size the array should be changed to.
                                                  ##  \return #RCUTILS_RET_OK if successful, or
                                                  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                                                  ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
                                                  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                                                  ##

proc rcutils_string_array_sort_compare*(lhs: pointer; rhs: pointer): cint {.
    cdecl, importc: "rcutils_string_array_sort_compare", clib.}
  ##
                              ##  Lexicographic comparer for pointers to string pointers.
                              ##
                              ##  This functions compares pointers to string pointers lexicographically
                              ##  ascending.
                              ##
                              ##  \param[in] lhs pointer to the first string pointer.
                              ##  \param[in] rhs pointer to the second string pointer.
                              ##  \return <0 if lhs is lexicographically lower, or
                              ##  \return 0 if the strings are the same, or
                              ##  \return >0 if lhs is lexicographically higher.
                              ##

proc rcutils_string_array_sort*(string_array: ptr rcutils_string_array_t): rcutils_ret_t {.
    inline, cdecl, importc: "rcutils_string_array_sort".}
  ##
                              ##  Sort a string array according to lexicographical order.
                              ##
                              ##  This function changes the order of the entries in a string array so that
                              ##  they are in lexicographically ascending order.
                              ##  Empty entries are placed at the end of the array.
                              ##
                              ##  \param[inout] string_array object whose elements should be sorted.
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ## 