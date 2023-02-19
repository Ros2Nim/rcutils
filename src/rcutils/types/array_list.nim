##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim render nobody

##  #pragma c2nim render nobody

import rcutils.allocator

type rcutils_array_list_impl_t* {.importc: "rcutils_array_list_impl_t", header: "array_list.h"} = object
  size*: csize_t
  capacity*: csize_t
  list*: pointer
  data_size*: csize_t
  allocator*: rcutils_allocator_t

##  Copyright 2018-2019 Open Source Robotics Foundation, Inc.
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
  rcutils.allocator, rcutils.allocator, rcutils.allocator, rcutils.macros,
  rcutils.macros, rcutils.macros, rcutils.macros, rcutils.macros, rcutils.allocator,
  rcutils.types.rcutils_ret, rcutils.allocator, rcutils.visibility_control,
  rcutils.visibility_control_macros, rcutils.visibility_control_macros,
  rcutils.visibility_control, rcutils.allocator

discard "forward decl of rcutils_array_list_impl_t"
type

  rcutils_array_list_t* {.importc: "rcutils_array_list_t", header: "array_list.h",
                         bycopy.} = object
    impl* {.importc: "impl".}: ptr rcutils_array_list_impl_t ##
                              ##  A pointer to the PIMPL implementation type.


##
##  Validates that an rcutils_array_list_t* points to a valid array list.
##  \param[in] array_list A pointer to an rcutils_array_list_t
##  \return RCUTILS_RET_INVALID_ARGUMENT if array_list is null
##  \return RCUTILS_RET_NOT_INITIALIZED if array_list is not initialized
##


proc rcutils_get_zero_initialized_array_list*(): rcutils_array_list_t {.cdecl,
    importc: "rcutils_get_zero_initialized_array_list", header: "array_list.h".}
  ##  Return an empty array_list struct.
  ##
  ##  This function returns an empty and zero initialized array_list struct.
  ##  Calling rcutils_array_list_fini() on any non-initialized instance leads
  ##  to undefined behavior.
  ##  Every instance of array_list_t has to either be zero_initialized with this
  ##  function or manually allocated.
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | No
  ##  Thread-Safe        | Yes
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##  Example:
  ##
  ##  ```c
  ##  rcutils_array_list_t foo;
  ##  rcutils_array_list_fini(&foo); // undefined behavior!
  ##
  ##  rcutils_array_list_t bar = rcutils_get_zero_initialized_array_list();
  ##  rcutils_array_list_fini(&bar); // ok
  ##  ```
  ##

proc rcutils_array_list_init*(array_list: ptr rcutils_array_list_t;
                             initial_capacity: csize_t; data_size: csize_t;
                             allocator: ptr rcutils_allocator_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_array_list_init", header: "array_list.h".}
  ##  Initialize an array list with a given initial capacity.
  ##
  ##  This function will initialize a given, zero initialized, array_list to
  ##  a given size.
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | Yes
  ##  Thread-Safe        | No
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##  Example:
  ##
  ##  ```c
  ##  rcutils_allocator_t allocator = rcutils_get_default_allocator();
  ##  rcutils_array_list_t array_list = rcutils_get_zero_initialized_array_list();
  ##  rcutils_ret_t ret = rcutils_array_list_init(&array_list, 2, sizeof(int), &allocator);
  ##  if (ret != RCUTILS_RET_OK) {
  ##    // ... error handling
  ##  }
  ##  int data = 42;
  ##  int out_data = 0;
  ##  ret = rcutils_array_list_add(&array_list, &data);
  ##  data++;
  ##  ret = rcutils_array_list_get(&array_list, 0, &out_data);
  ##  assert(42 == out_data);
  ##  ret = rcutils_array_list_fini(&array_list);
  ##  ```
  ##
  ##  \param[inout] array_list object to be initialized
  ##  \param[in] initial_capacity the initial capacity to allocate in the list
  ##  \param[in] data_size the size (in bytes) of the data object being stored in the list
  ##  \param[in] allocator to be used to allocate and deallocate memory
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
  ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
  ##

proc rcutils_array_list_fini*(array_list: ptr rcutils_array_list_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_array_list_fini", header: "array_list.h".}
  ##  Finalize an array list, reclaiming all resources.
  ##
  ##  This function reclaims any memory owned by the array list.
  ##
  ##  The allocator used to initialize the array list is used to deallocate each
  ##  entry in the list and the list itself.
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | No
  ##  Thread-Safe        | No
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##  \param[inout] array_list object to be finalized
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
  ##

proc rcutils_array_list_add*(array_list: ptr rcutils_array_list_t; data: pointer): rcutils_ret_t {.
    cdecl, importc: "rcutils_array_list_add", header: "array_list.h".}
  ##  Adds an entry to the list
  ##
  ##  This function adds the provided data to the end of the list. A shallow copy of
  ##  the provided data is made to store in the list instead of just storing
  ##  the pointer to the provided data.
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | Yes
  ##  Thread-Safe        | No
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##  \param[in] array_list to add the data to
  ##  \param[in] data a pointer to the data to add to the list
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
  ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
  ##

proc rcutils_array_list_set*(array_list: ptr rcutils_array_list_t; index: csize_t;
                            data: pointer): rcutils_ret_t {.cdecl,
    importc: "rcutils_array_list_set", header: "array_list.h".}
  ##  Sets an entry in the list to the provided data
  ##
  ##  This function sets the provided data at the specified index in the list.
  ##  A shallow copy of the provided data is made to store in the list instead
  ##  of just storing the pointer to the provided data.
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | No
  ##  Thread-Safe        | No
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##  \param[in] array_list to add the data to
  ##  \param[in] index the position in the list to set the data
  ##  \param[in] data a pointer to the data that will be set in the list
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT if index out of bounds, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
  ##

proc rcutils_array_list_remove*(array_list: ptr rcutils_array_list_t; index: csize_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_array_list_remove", header: "array_list.h".}
  ##  Removes an entry in the list at the provided index
  ##
  ##  This function removes data from the list at the specified index. The capacity
  ##  of the list will never decrease when entries are removed.
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | No
  ##  Thread-Safe        | No
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##  \param[in] array_list to add the data to
  ##  \param[in] index the index of the item to remove from the list
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT if index out of bounds, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
  ##

proc rcutils_array_list_get*(array_list: ptr rcutils_array_list_t; index: csize_t;
                            data: pointer): rcutils_ret_t {.cdecl,
    importc: "rcutils_array_list_get", header: "array_list.h".}
  ##  Retrieves an entry in the list at the provided index
  ##
  ##  This function retrieves a copy of the data stored in the list at the provided index.
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | No
  ##  Thread-Safe        | No
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##
  ##  \param[in] array_list to add the data to
  ##  \param[in] index the index at which to get the data
  ##  \param[out] data a copy of the data stored in the list
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
  ##

proc rcutils_array_list_get_size*(array_list: ptr rcutils_array_list_t;
                                 size: ptr csize_t): rcutils_ret_t {.cdecl,
    importc: "rcutils_array_list_get_size", header: "array_list.h".}
  ##  Retrieves the size of the provided array_list
  ##
  ##  This function retrieves the number of items in the provided array list
  ##
  ##  <hr>
  ##  Attribute          | Adherence
  ##  ------------------ | -------------
  ##  Allocates Memory   | No
  ##  Thread-Safe        | No
  ##  Uses Atomics       | No
  ##  Lock-Free          | Yes
  ##
  ##
  ##  \param[in] array_list list to get the size of
  ##  \param[out] size The number of items currently stored in the list
  ##  \return #RCUTILS_RET_OK if successful, or
  ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
  ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
  ## 