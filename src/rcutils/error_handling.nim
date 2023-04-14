

proc RCUTILS_SAFE_FWRITE_TO_STDERR*(msg: cstring) {.importc: "$1", header: "error_handling.h".}
const rcutilsDynlib {.strdefine.}: string = ""
when rcutilsDynlib == "":
  {.pragma: clib, header: "rcutils/error_handling.h" .}
else:
  {.pragma: clib, dynlib: "" & rcutilsDynlib.}

##  Copyright 2014 Open Source Robotics Foundation, Inc.
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
  ./allocator,              ##  clang -E -dI
  ./macros, ./types/rcutils_ret, ./visibility_control,
  ./visibility_control_macros, ./snprintf, ##  clang -E -dI
  ./testing/fault_injection

##  clang -E -dI
##  Write the given msg out to stderr.

##  Set the error message to stderr using a format string and format arguments.
##
##  This function sets the error message to stderr using the given format string.
##  The resulting formatted string is silently truncated at
##  RCUTILS_ERROR_MESSAGE_MAX_LENGTH.
##
##  \param[in] format_string The string to be used as the format of the error message.
##  \param[in] ... Arguments for the format string.
##

const
  RCUTILS_ERROR_STATE_LINE_NUMBER_STR_MAX_LENGTH* = 20 ##
                              ##  The maximum length a formatted number is allowed to have.
  RCUTILS_ERROR_FORMATTING_CHARACTERS* = 6 ##  The maximum number of formatting characters allowed.
  RCUTILS_ERROR_MESSAGE_MAX_LENGTH* = 1024 ##  The maximum formatted string length.
  RCUTILS_ERROR_STATE_MESSAGE_MAX_LENGTH* = 768 ##  The maximum length for user defined error message
                                                ##
                                                ##  Remember that "chained" errors will include previously specified file paths
                                                ##  e.g. "some error, at /path/to/a.c:42, at /path/to/b.c:42"
                                                ##

type

  rcutils_error_string_t* {.importc: "rcutils_error_string_t",
                            header: "rcutils/error_handling.h", bycopy.} = object ##
                              ##  Struct wrapping a fixed-size c string used for returning the formatted error string.
    str* {.importc: "str".}: array[1024, char] ##  The fixed-size C string used for returning the formatted error string.


  rcutils_error_state_t* {.importc: "rcutils_error_state_t",
                           header: "rcutils/error_handling.h", bycopy.} = object ##
                              ##  Struct which encapsulates the error state set by RCUTILS_SET_ERROR_MSG().
    message* {.importc: "message".}: array[768, char] ##
                              ##  User message storage, limited to RCUTILS_ERROR_STATE_MESSAGE_MAX_LENGTH characters.
    file* {.importc: "file".}: array[(1024 - 768 - 20 - 6 - 1), char] ##
                              ##  File name, limited to what's left from RCUTILS_ERROR_STATE_MAX_SIZE characters
                              ##  after subtracting storage for others.
    line_number* {.importc: "line_number".}: uint64 ##
                              ##  Line number of error.




proc rcutils_initialize_error_handling_thread_local_storage*(
    allocator: rcutils_allocator_t): rcutils_ret_t {.cdecl,
    importc: "rcutils_initialize_error_handling_thread_local_storage", clib.}
  ##
                              ##  Forces initialization of thread-local storage if called in a newly created thread.
                              ##
                              ##  If this function is not called beforehand, then the first time the error
                              ##  state is set or the first time the error message is retrieved, the default
                              ##  allocator will be used to allocate thread-local storage.
                              ##
                              ##  This function may or may not allocate memory.
                              ##  The system's thread-local storage implementation may need to allocate
                              ##  memory, since it usually has no way of knowing how much storage is needed
                              ##  without knowing how many threads will be created.
                              ##  Most implementations (e.g. C11, C++11, and pthread) do not have ways to
                              ##  specify how this memory is allocated, but if the implementation allows, the
                              ##  given allocator to this function will be used, but is otherwise unused.
                              ##  This only occurs when creating and destroying threads, which can be avoided
                              ##  in the "steady" state by reusing pools of threads.
                              ##
                              ##  It is worth considering that repeated thread creation and destruction will
                              ##  result in repeated memory allocations and could result in memory
                              ##  fragmentation.
                              ##  This is typically avoided anyways by using pools of threads.
                              ##
                              ##  In case an error is indicated by the return code, no error message will have
                              ##  been set.
                              ##
                              ##  If called more than once in a thread, or after implicitly initialized by
                              ##  setting the error state, it will still return `RCUTILS_RET_OK`, even
                              ##  if the given allocator is invalid.
                              ##  Essentially this function does nothing if thread-local storage has already
                              ##  been called.
                              ##  If already initialized, the given allocator is ignored, even if it does not
                              ##  match the allocator used originally to initialize the thread-local storage.
                              ##
                              ##  \param[in] allocator to be used to allocate and deallocate memory
                              ##  \return #RCUTILS_RET_OK if successful, or
                              ##  \return #RCUTILS_RET_INVALID_ARGUMENT if the allocator is invalid, or
                              ##  \return #RCUTILS_RET_BAD_ALLOC if allocating memory fails, or
                              ##  \return #RCUTILS_RET_ERROR if an unspecified error occurs.
                              ##

proc rcutils_set_error_state*(error_string: cstring; file: cstring;
                              line_number: csize_t) {.cdecl,
    importc: "rcutils_set_error_state", clib.}
  ##  Set the error message, as well as the file and line on which it occurred.
                                              ##
                                              ##  This is not meant to be used directly, but instead via the
                                              ##  RCUTILS_SET_ERROR_MSG(msg) macro.
                                              ##
                                              ##  The error_msg parameter is copied into the internal error storage and must
                                              ##  be null terminated.
                                              ##  The file parameter is copied into the internal error storage and must
                                              ##  be null terminated.
                                              ##
                                              ##  \param[in] error_string The error message to set.
                                              ##  \param[in] file The path to the file in which the error occurred.
                                              ##  \param[in] line_number The line number on which the error occurred.
                                              ##
##  Check an argument for a null value.
##
##  If the argument's value is `NULL`, set the error message saying so and
##  return the `error_return_type`.
##
##  \param[in] argument The argument to test.
##  \param[in] error_return_type The type to return if the argument is `NULL`.
##

##  Check a value for null, with an error message and error statement.
##
##  If `value` is `NULL`, the error statement will be evaluated after
##  setting the error message.
##
##  \param[in] value The value to test.
##  \param[in] msg The error message if `value` is `NULL`.
##  \param[in] error_statement The statement to evaluate if `value` is `NULL`.
##

##  Set the error message, as well as append the current file and line number.
##
##  If an error message was previously set, and rcutils_reset_error() was not called
##  afterwards, and this library was built with RCUTILS_REPORT_ERROR_HANDLING_ERRORS
##  turned on, then the previously set error message will be printed to stderr.
##  Error state storage is thread local and so all error related functions are
##  also thread local.
##
##  \param[in] msg The error message to be set.
##

##  Set the error message using a format string and format arguments.
##
##  This function sets the error message using the given format string.
##  The resulting formatted string is silently truncated at
##  RCUTILS_ERROR_MESSAGE_MAX_LENGTH.
##
##  \param[in] format_string The string to be used as the format of the error message.
##  \param[in] ... Arguments for the format string.
##

##  Indicate that the function intends to set an error message and return an error value.
##
##  \def RCUTILS_CAN_SET_MSG_AND_RETURN_WITH_ERROR_OF
##  Indicating macro similar to RCUTILS_CAN_RETURN_WITH_ERROR_OF, that also sets an error
##  message.
##
##  For now, this macro simply relies on `RCUTILS_CAN_FAIL_WITH` to set a generic error
##  message and return the given `error_return_value` if fault injection is enabled.
##
##  \param error_return_value the value returned as a result of a given error.
##


proc rcutils_error_is_set*(): bool {.cdecl, importc: "rcutils_error_is_set",
                                     clib.}
  ##  Return `true` if the error is set, otherwise `false`.

proc rcutils_get_error_state*(): ptr rcutils_error_state_t {.cdecl,
    importc: "rcutils_get_error_state", clib.}
  ##  Return an rcutils_error_state_t which was set with rcutils_set_error_state().
                                              ##
                                              ##  The returned pointer will be NULL if no error has been set in this thread.
                                              ##
                                              ##  The returned pointer is valid until RCUTILS_SET_ERROR_MSG, rcutils_set_error_state,
                                              ##  or rcutils_reset_error are called in the same thread.
                                              ##
                                              ##  \return A pointer to the current error state struct.
                                              ##

proc rcutils_get_error_string*(): rcutils_error_string_t {.cdecl,
    importc: "rcutils_get_error_string", clib.}
  ##  Return the error message followed by `, at <file>:<line>` if set, else "error not set".
                                               ##
                                               ##  This function is "safe" because it returns a copy of the current error
                                               ##  string or one containing the string "error not set" if no error was set.
                                               ##  This ensures that the copy is owned by the calling thread and is therefore
                                               ##  never invalidated by other error handling calls, and that the C string
                                               ##  inside is always valid and null terminated.
                                               ##
                                               ##  \return The current error string, with file and line number, or "error not set" if not set.
                                               ##

proc rcutils_reset_error*() {.cdecl, importc: "rcutils_reset_error", clib.}
  ##
                              ##  Reset the error state by clearing any previously set error state.