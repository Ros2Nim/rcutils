##  #pragma c2nim cdecl

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
  ./allocator, ./macros, ./types/rcutils_ret, ./visibility_control,
  ./visibility_control_macros


type

  rcutils_shared_library_t* {.importc: "rcutils_shared_library_t",
                              header: "rcutils/shared_library.h", bycopy.} = object ##
                              ##  Handle to a loaded shared library.
    lib_pointer* {.importc: "lib_pointer".}: pointer ##
                              ##  The platform-specific pointer to the shared library
    library_path* {.importc: "library_path".}: cstring ##
                              ##  The path of the shared_library
    allocator* {.importc: "allocator".}: rcutils_allocator_t ##
                              ##  allocator




proc rcutils_get_zero_initialized_shared_library*(): rcutils_shared_library_t {.
    importc: "rcutils_get_zero_initialized_shared_library",
    header: "rcutils/shared_library.h".}
  ##  Return an empty shared library struct.
                                        ##
                                        ##  This function returns an empty and zero initialized shared library struct.
                                        ##
                                        ##  Example:
                                        ##
                                        ##  ```c
                                        ##  // Do not do this:
                                        ##  // rcutils_shared_library_t foo;
                                        ##  // rcutils_ret_t ret = rcutils_load_shared_library(
                                        ##  //     &foo,
                                        ##  //    "library_name",
                                        ##  //    rcutils_get_default_allocator()); // undefined behavior!
                                        ##  // or
                                        ##  // rcutils_ret_t ret = rcutils_unload_shared_library(&foo); // undefined behavior!
                                        ##
                                        ##  // Do this instead:
                                        ##  rcutils_shared_library_t bar = rcutils_get_zero_initialized_shared_library();
                                        ##  rcutils_load_shared_library(&bar, "library_name", rcutils_get_default_allocator()); // ok
                                        ##  void * symbol = rcutils_get_symbol(&bar, "bazinga"); // ok
                                        ##  bool is_bazinga_symbol = rcutils_has_symbol(&bar, "bazinga"); // ok
                                        ##  rcutils_ret_t ret = rcutils_unload_shared_library(&bar); // ok
                                        ##  if (ret != RCUTILS_RET_ERROR) {
                                        ##    // error handling
                                        ##  }
                                        ##  ```
                                        ##

proc rcutils_load_shared_library*(lib: ptr rcutils_shared_library_t;
                                  library_path: cstring;
                                  allocator: rcutils_allocator_t): rcutils_ret_t {.
    importc: "rcutils_load_shared_library", header: "rcutils/shared_library.h".}
  ##
                              ##  Return shared library pointer.
                              ##
                              ##  \param[inout] lib struct with the shared library pointer and shared library path name
                              ##  \param[in] library_path string with the path of the library
                              ##  \param[in] allocator to be used to allocate and deallocate memory
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments.
                              ##

proc rcutils_get_symbol*(lib: ptr rcutils_shared_library_t; symbol_name: cstring): pointer {.
    importc: "rcutils_get_symbol", header: "rcutils/shared_library.h".}
  ##
                              ##  Return shared library symbol pointer.
                              ##
                              ##  \param[in] lib struct with the shared library pointer and shared library path name
                              ##  \param[in] symbol_name name of the symbol inside the shared library
                              ##  \return shared library symbol pointer, or
                              ##  \return `NULL` if the symbol doesn't exist.
                              ##

proc rcutils_has_symbol*(lib: ptr rcutils_shared_library_t; symbol_name: cstring): bool {.
    importc: "rcutils_has_symbol", header: "rcutils/shared_library.h".}
  ##
                              ##  Return true if the shared library contains a specific symbol name otherwise returns false.
                              ##
                              ##  \param[in] lib struct with the shared library pointer and shared library path name
                              ##  \param[in] symbol_name name of the symbol inside the shared library
                              ##  \return `true` if the symbol exists, or
                              ##  \return `false` otherwise.
                              ##

proc rcutils_unload_shared_library*(lib: ptr rcutils_shared_library_t): rcutils_ret_t {.
    importc: "rcutils_unload_shared_library", header: "rcutils/shared_library.h".}
  ##
                              ##  Unload the shared library.
                              ##
                              ##  \param[in] lib rcutils_shared_library_t to be finalized
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs
                              ##

proc rcutils_is_shared_library_loaded*(lib: ptr rcutils_shared_library_t): bool {.
    importc: "rcutils_is_shared_library_loaded",
    header: "rcutils/shared_library.h".}
  ##  Check if the library is loaded.
                                        ##
                                        ##  This function only determines if "unload" has been called on the current shared library handle.
                                        ##  It could very well be that a second shared library handle is still open and therefore the library
                                        ##  being loaded.
                                        ##  \param[in] lib rcutils_shared_library_t  to check
                                        ##  \return `true` if library is loaded, or
                                        ##  \return `false` otherwise.
                                        ##

proc rcutils_get_platform_library_name*(library_name: cstring;
                                        library_name_platform: cstring;
                                        buffer_size: cuint; debug: bool): rcutils_ret_t {.
    importc: "rcutils_get_platform_library_name",
    header: "rcutils/shared_library.h".}
  ##  Get the library name for the compiled platform
                                        ##
                                        ##  \param[in] library_name library base name (without prefix and extension)
                                        ##  \param[out] library_name_platform library name for the compiled platform
                                        ##  \param[in] buffer_size size of library_name_platform buffer
                                        ##  \param[in] debug if true the library will return a debug library name, otherwise
                                        ##  it returns a normal library path
                                        ##  \return #RCUTILS_RET_OK if successful, or
                                        ##  \return #RCUTILS_RET_ERROR if an unknown error occurs
                                        ## 