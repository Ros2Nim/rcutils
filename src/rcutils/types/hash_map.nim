import rcutils_ret
import ../allocator
import array_list

type

  rcutils_hash_map_impl_s* {.importc: "rcutils_hash_map_impl_s",
                             header: "hash_map.h", bycopy.} = object ##
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


  rcutils_hash_map_t* {.importc: "rcutils_hash_map_t", header: "hash_map.h",
                        bycopy.} = object ##  The structure holding the metadata for a hash map.
    impl* {.importc: "impl".}: ptr rcutils_hash_map_impl_s ##
                              ##  A pointer to the PIMPL implementation type.


  rcutils_hash_map_key_hasher_t* = proc (a1: pointer): csize_t {.cdecl.} ##
                              ##  The function signature for a key hashing function.
                              ##
                              ##  \param[in] key The key that needs to be hashed
                              ##  \return A hash value for the provided string
                              ##

  rcutils_hash_map_key_cmp_t* = proc (a1: pointer; a2: pointer): cint {.cdecl.} ##
                              ##  The function signature for a key comparison function.
                              ##
                              ##  \param[in] val1 The first value to compare
                              ##  \param[in] val2 The second value to compare
                              ##  \return A negative number if val1 < val2, or
                              ##  \return A positve number if val1 > val2, or
                              ##  \return Zero if val1 == val2.
                              ##
  ##  val1

##
##  Validates that an rcutils_hash_map_t* points to a valid hash map.
##  \param[in] map A pointer to an rcutils_hash_map_t
##  \return #RCUTILS_RET_INVALID_ARGUMENT if map is null
##  \return #RCUTILS_RET_NOT_INITIALIZED if map is not initialized.
##


proc rcutils_hash_map_string_hash_func*(key_str: pointer): csize_t {.cdecl,
    importc: "rcutils_hash_map_string_hash_func", header: "hash_map.h".}
  ##
                              ##  A hashing function for a null terminated c string.
                              ##
                              ##  A hashing function for a null terminated c string.
                              ##  Should be used when your key is just a pointer to a c-string
                              ##

proc rcutils_hash_map_string_cmp_func*(val1: pointer; val2: pointer): cint {.
    cdecl, importc: "rcutils_hash_map_string_cmp_func", header: "hash_map.h".}
  ##
                              ##  A comparison function for a null terminated c string.
                              ##
                              ##  A comparison function for a null terminated c string.
                              ##  Should be used when your key is just a pointer to a c-string
                              ##

proc rcutils_get_zero_initialized_hash_map*(): rcutils_hash_map_t {.cdecl,
    importc: "rcutils_get_zero_initialized_hash_map", header: "hash_map.h".}
  ##
                              ##  Return an empty hash_map struct.
                              ##
                              ##  This function returns an empty and zero initialized hash_map struct.
                              ##  All hash maps should be initialized with this or manually initialized
                              ##  before being used.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  Example:
                              ##  ```c
                              ##  // Do not do this:
                              ##  // rcutils_hash_map_t foo;
                              ##  // rcutils_hash_map_fini(&foo); // undefined behavior!
                              ##
                              ##  // Do this instead:
                              ##  rcutils_hash_map_t bar = rcutils_get_zero_initialized_hash_map();
                              ##  rcutils_hash_map_fini(&bar); // ok
                              ##  ```
                              ##

proc rcutils_hash_map_init*(hash_map: ptr rcutils_hash_map_t;
                            initial_capacity: csize_t; key_size: csize_t;
                            data_size: csize_t;
                            key_hashing_func: rcutils_hash_map_key_hasher_t;
                            key_cmp_func: rcutils_hash_map_key_cmp_t;
                            allocator: ptr rcutils_allocator_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_hash_map_init", header: "hash_map.h".}
  ##
                              ##  Initialize a rcutils_hash_map_t, allocating space for given capacity.
                              ##
                              ##  This function initializes the rcutils_hash_map_t with a given initial
                              ##  capacity for entries.
                              ##  Note this does not allocate space for keys or values in the hash_map, just the
                              ##  arrays of pointers to the keys and values.
                              ##  rcutils_hash_map_set() should still be used when assigning values.
                              ##
                              ##  The hash_map argument should point to allocated memory and should have
                              ##  been zero initialized with rcutils_get_zero_initialized_hash_map().
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
                              ##  ```c
                              ##  rcutils_hash_map_t hash_map = rcutils_get_zero_initialized_hash_map();
                              ##  rcutils_ret_t ret =
                              ##    rcutils_hash_map_init(&hash_map, 10, rcutils_get_default_allocator());
                              ##  if (ret != RCUTILS_RET_OK) {
                              ##    // ... do error handling
                              ##  }
                              ##  // ... use the hash_map and when done:
                              ##  ret = rcutils_hash_map_fini(&hash_map);
                              ##  if (ret != RCUTILS_RET_OK) {
                              ##    // ... do error handling
                              ##  }
                              ##  ```
                              ##
                              ##  \param[inout] hash_map rcutils_hash_map_t to be initialized
                              ##  \param[in] initial_capacity the amount of initial capacity for the hash_map - this must be greater than zero and a power of 2
                              ##  \param[in] key_size the size (in bytes) of the key used to index the data
                              ##  \param[in] data_size the size (in bytes) of the data being stored
                              ##  \param[in] key_hashing_func a function that returns a hashed value for a key
                              ##  \param[in] key_cmp_func a function used to compare keys
                              ##  \param[in] allocator the allocator to use through out the lifetime of the hash_map
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
                              ##  \return #RCUTILS_RET_STRING_MAP_ALREADY_INIT if alread initialized, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_hash_map_fini*(hash_map: ptr rcutils_hash_map_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_hash_map_fini", header: "hash_map.h".}
  ##
                              ##  Finalize the previously initialized hash_map struct.
                              ##
                              ##  This function will free any resources which were created when initializing
                              ##  or when calling rcutils_hash_map_set().
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[inout] hash_map rcutils_hash_map_t to be finalized
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_hash_map_get_capacity*(hash_map: ptr rcutils_hash_map_t;
                                    capacity: ptr csize_t): rcutils_ret_t {.
    cdecl, importc: "rcutils_hash_map_get_capacity", header: "hash_map.h".}
  ##
                              ##  Get the current capacity of the hash_map.
                              ##
                              ##  This function will return the internal capacity of the hash_map, which is the
                              ##  number of buckets the hash_map uses to sort the keys.
                              ##  The capacity does not indicate how many key value pairs are stored in the
                              ##  hash_map, the rcutils_hash_map_get_size() function can provide that, nor the
                              ##  maximum number that can be stored without increasing the capacity.
                              ##  The capacity can be set initially with rcutils_hash_map_init().
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[in] hash_map rcutils_hash_map_t to be queried
                              ##  \param[out] capacity capacity of the hash_map
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_NOT_INITIALIZED if the hash_map is invalid, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_hash_map_get_size*(hash_map: ptr rcutils_hash_map_t;
                                size: ptr csize_t): rcutils_ret_t {.cdecl,
    importc: "rcutils_hash_map_get_size", header: "hash_map.h".}
  ##
                              ##  Get the current size of the hash_map.
                              ##
                              ##  This function will return the internal size of the hash_map, which is the
                              ##  current number of key value pairs in the hash_map.
                              ##  The size is changed when calling rcutils_hash_map_set() or rcutils_hash_map_unset().
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[in] hash_map rcutils_hash_map_t to be queried
                              ##  \param[out] size size of the hash_map
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_NOT_INITIALIZED if the hash_map is invalid, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_hash_map_set*(hash_map: ptr rcutils_hash_map_t; key: pointer;
                           value: pointer): rcutils_ret_t {.cdecl,
    importc: "rcutils_hash_map_set", header: "hash_map.h".}
  ##
                              ##  Set a key value pair in the hash_map, increasing capacity if necessary.
                              ##
                              ##  If the key already exists in the map then the value is updated to the new value
                              ##  provided. If it does not already exist then a new entry is added for the new key
                              ##  and value. The capacity will be increased if needed.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | Yes
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[inout] hash_map rcutils_hash_map_t to be updated
                              ##  \param[in] key hash_map key
                              ##  \param[in] value value for given hash_map key
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation fails, or
                              ##  \return #RCUTILS_RET_NOT_INITIALIZED if the hash_map is invalid, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_hash_map_unset*(hash_map: ptr rcutils_hash_map_t; key: pointer): rcutils_ret_t {.
    cdecl, importc: "rcutils_hash_map_unset", header: "hash_map.h".}
  ##
                              ##  Unset a key value pair in the hash_map.
                              ##
                              ##  Unsets the key value pair in the hash_map and frees any internal resources allocated
                              ##  for the entry. This function will never decrease the capacity when removing keys.
                              ##  If the given key is not found, RCUTILS_RET_STRING_KEY_NOT_FOUND is returned.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[inout] hash_map rcutils_hash_map_t to be updated
                              ##  \param[in] key hash_map key, must be null terminated c string
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_NOT_INITIALIZED if the hash_map is invalid, or
                              ##  \return #RCUTILS_RET_STRING_KEY_NOT_FOUND if the key is not found in the map, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_hash_map_key_exists*(hash_map: ptr rcutils_hash_map_t; key: pointer): bool {.
    cdecl, importc: "rcutils_hash_map_key_exists", header: "hash_map.h".}
  ##
                              ##  Get whether or not a key exists.
                              ##
                              ##  Returns true if the provided key exists in the hash_map or false if it does not or
                              ##  if the hash_map or key are invalid.
                              ##  In all cases no error message is set.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[in] hash_map rcutils_hash_map_t to be searched
                              ##  \param[in] key hash_map key, must be null terminated c string
                              ##  \return `true` if key is in the hash_map, or
                              ##  \return `false` if key is not in the hash_map, or
                              ##  \return `false` for invalid arguments, or
                              ##  \return `false` if the hash_map is invalid.
                              ##

proc rcutils_hash_map_get*(hash_map: ptr rcutils_hash_map_t; key: pointer;
                           data: pointer): rcutils_ret_t {.cdecl,
    importc: "rcutils_hash_map_get", header: "hash_map.h".}
  ##
                              ##  Get value given a key.
                              ##
                              ##  This function can be used to retrieve a shallow copy of the stored data. The data
                              ##  pointer must point to a section of memory large enough to copy the full size of
                              ##  the data being stored, which is specified when the hash_map in initialized.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  \param[in] hash_map rcutils_hash_map_t to be searched
                              ##  \param[in] key hash_map key to look up the data for
                              ##  \param[out] data A copy of the data stored in the map
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_NOT_INITIALIZED if the hash_map is invalid, or
                              ##  \return #RCUTILS_RET_NOT_FOUND if the key doesn't exist in the map, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ##

proc rcutils_hash_map_get_next_key_and_data*(hash_map: ptr rcutils_hash_map_t;
    previous_key: pointer; key: pointer; data: pointer): rcutils_ret_t {.cdecl,
    importc: "rcutils_hash_map_get_next_key_and_data", header: "hash_map.h".}
  ##
                              ##  Get the next key in the hash_map, unless NULL is given, then get the first key.
                              ##
                              ##  This function allows you to iteratively get each key/value pair in the hash_map.
                              ##
                              ##  If NULL is given for the previous_key, then the first key in the hash_map is returned.
                              ##  If that returned key is given as the previous_key for the next call to this function,
                              ##  then the next key in the hash_map is returned.
                              ##  If there are no more keys in the hash_map or if the given key is not in the hash_map,
                              ##  an error will be returned.
                              ##
                              ##  The order of the keys in the hash_map is arbitrary and if the hash_map is modified
                              ##  between calls to this function the behavior is undefined.
                              ##  If the hash_map is modified then iteration should begin again by passing NULL to
                              ##  get the first key again.
                              ##
                              ##  <hr>
                              ##  Attribute          | Adherence
                              ##  ------------------ | -------------
                              ##  Allocates Memory   | No
                              ##  Thread-Safe        | No
                              ##  Uses Atomics       | No
                              ##  Lock-Free          | Yes
                              ##
                              ##  Example:
                              ##  ```c
                              ##  printf("entries in the hash_map:\n");
                              ##  int key = 0, data = 0;
                              ##  rcutils_ret_t status = rcutils_hash_map_get_next_key(&hash_map, NULL, &key, &data);
                              ##  while (RCUTILS_RET_OK == status) {
                              ##    printf("%i: %i\n", key, data);
                              ##    status = rcutils_hash_map_get_next_key(&hash_map, &key, &key, &data);
                              ##  }
                              ##  ```
                              ##
                              ##  \param[in] hash_map rcutils_hash_map_t to be queried
                              ##  \param[in] previous_key NULL to get the first key or the previous key to get the next for
                              ##  \param[out] key A copy of the next key in the sequence
                              ##  \param[out] data A copy of the next data in the sequence
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT for invalid arguments, or
                              ##  \return #RCUTILS_RET_NOT_INITIALIZED if the hash_map is invalid, or
                              ##  \return #RCUTILS_RET_NOT_FOUND if the previous_key doesn't exist in the map, or
                              ##  \return #RCUTILS_RET_HASH_MAP_NO_MORE_ENTRIES if there is no more data beyound the previous_key, or
                              ##  \return #RCUTILS_RET_ERROR if an unknown error occurs.
                              ## 