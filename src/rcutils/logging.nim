##  #pragma c2nim nep1

##  #pragma c2nim reordertypes

##  #pragma c2nim header

##  #pragma c2nim importc

##  #pragma c2nim render nobody

import ./time
proc RCUTILS_LOGGING_AUTOINIT*() {.importc: "RCUTILS_LOGGING_AUTOINIT", header: "rcutils/logging.h".}

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

import
  rcutils.allocator, rcutils.allocator, rcutils.macros, rcutils.macros,
  rcutils.macros, rcutils.macros, rcutils.macros, rcutils.allocator,
  rcutils.types.rcutils_ret, rcutils.allocator, rcutils.visibility_control,
  rcutils.visibility_control_macros, rcutils.visibility_control_macros,
  rcutils.visibility_control, rcutils.allocator, rcutils.error_handling,
  rcutils.error_handling, rcutils.error_handling, rcutils.error_handling,
  rcutils.error_handling, rcutils.error_handling, rcutils.error_handling,
  rcutils.snprintf, rcutils.snprintf, rcutils.error_handling,
  rcutils.testing.fault_injection, rcutils.testing.fault_injection,
  rcutils.testing.fault_injection, rcutils.error_handling, rcutils.error_handling,
  rcutils.error_handling, rcutils.error_handling, rcutils.time, rcutils.time,
  rcutils.types, rcutils.types.array_list, rcutils.types.array_list, rcutils.types,
  rcutils.types.char_array, rcutils.types.char_array, rcutils.types,
  rcutils.types.hash_map, rcutils.types.hash_map, rcutils.types,
  rcutils.types.string_array, rcutils.types.string_array, rcutils.qsort,
  rcutils.qsort, rcutils.types.string_array, rcutils.types,
  rcutils.types.string_map, rcutils.types.string_map, rcutils.types,
  rcutils.types.uint8_array, rcutils.types.uint8_array, rcutils.types, rcutils.time

const
  RCUTILS_LOGGING_SEPARATOR_STRING* = "." ##  The separator used when logging node names.
  RCUTILS_DEFAULT_LOGGER_DEFAULT_LEVEL* = RCUTILS_LOG_SEVERITY_INFO ##
                              ##
                              ##  \def RCUTILS_DEFAULT_LOGGER_DEFAULT_LEVEL
                              ##  \brief The default severity level of the default logger.
                              ##

var g_rcutils_logging_initialized* {.importc: "g_rcutils_logging_initialized",
                                   header: "logging.h".}: bool


proc rcutils_logging_initialize_with_allocator*(allocator: rcutils_allocator_t): rcutils_ret_t {.
    importc: "rcutils_logging_initialize_with_allocator", header: "logging.h".}

proc rcutils_logging_initialize*(): rcutils_ret_t {.
    importc: "rcutils_logging_initialize", header: "logging.h".}

proc rcutils_logging_shutdown*(): rcutils_ret_t {.
    importc: "rcutils_logging_shutdown", header: "logging.h".}
type                          ##  The flag if the logging system has been initialized.
##  Initialize the logging system using the specified allocator.
##
##  Initialize the logging system only if it was not in an initialized state.
##
##  If an invalid allocator is passed, the initialization will fail.
##  Otherwise, this function will still set the internal state to initialized
##  even if an error occurs, to avoid repeated failing initialization attempts
##  since this function is called automatically from logging macros.
##  To re-attempt initialization, call rcutils_logging_shutdown() before
##  re-calling this function.
##
##  If multiple errors occur, the error code of the last error will be returned.
##
##  The `RCUTILS_CONSOLE_OUTPUT_FORMAT` environment variable can be used to set
##  the output format of messages logged to the console.
##  Available tokens are:
##    - `file_name`, the full file name of the caller including the path
##    - `function_name`, the function name of the caller
##    - `line_number`, the line number of the caller
##    - `message`, the message string after it has been formatted
##    - `name`, the full logger name
##    - `severity`, the name of the severity level, e.g. `INFO`
##    - `time`, the timestamp of log message in floating point seconds
##    - `time_as_nanoseconds`, the timestamp of log message in integer nanoseconds
##
##  The `RCUTILS_COLORIZED_OUTPUT` environment variable allows configuring if colours
##  are used or not. Available values are:
##   - `1`: Force using colours.
##   - `0`: Don't use colours.
##  If it is unset, colours are used depending if the target stream is a terminal or not.
##  See `isatty` documentation.
##
##  The format string can use these tokens by referencing them in curly brackets,
##  e.g. `"[{severity}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})"`.
##  Any number of tokens can be used.
##  The limit of the format string is 2048 characters.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | Yes
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] allocator rcutils_allocator_t to be used.
##  \return #RCUTILS_RET_OK if successful, or
##  \return #RCUTILS_RET_INVALID_ARGUMENT if the allocator is invalid, in which
##    case initialization will fail, or
##  \return #RCUTILS_RET_INVALID_ARGUMENT if an error occurs reading the output
##    format from the `RCUTILS_CONSOLE_OUTPUT_FORMAT` environment variable, in
##    which case the default format will be used, or
##  \return #RCUTILS_RET_LOGGING_SEVERITY_MAP_INVALID if the internal logger
##    severity level map cannot be initialized, in which case logger severity
##    levels will not be configurable.
##
##  Initialize the logging system.
##
##  Call rcutils_logging_initialize_with_allocator() using the default allocator.
##  This function is called automatically when using the logging macros.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | Yes
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \return #RCUTILS_RET_OK if successful, or
##  \return #RCUTILS_RET_INVALID_ARGUMENT if an error occurs reading the output
##    format from the `RCUTILS_CONSOLE_OUTPUT_FORMAT` environment variable, in
##    which case the default format will be used, or
##  \return #RCUTILS_RET_LOGGING_SEVERITY_MAP_INVALID if the internal logger
##    severity level map cannot be initialized, in which case logger levels
##    will not be configurable.
##
##  Shutdown the logging system.
##
##  Free the resources allocated for the logging system.
##  This puts the system into a state equivalent to being uninitialized.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \return #RCUTILS_RET_OK if successful, or
##  \return #RCUTILS_RET_LOGGING_SEVERITY_MAP_INVALID if the internal logger
##    severity level map cannot be finalized.
##

  rcutils_log_location_t* {.importc: "rcutils_log_location_t", header: "logging.h",
                           bycopy.} = object ##  The structure identifying the caller location in the source code.
    function_name* {.importc: "function_name".}: cstring ##
                              ##  The name of the function containing the log call.
    file_name* {.importc: "file_name".}: cstring ##  The name of the source file containing the log call.
    line_number* {.importc: "line_number".}: csize_t ##  The line number containing the log call.


  RCUTILS_LOG_SEVERITY* {.size: sizeof(cint).} = enum ##  The severity levels of log messages / loggers.
                                                 ##
                                                 ##  Note: all logging levels have their Least Significant Bit as 0, which is used as an
                                                 ##  optimization.  If adding new logging levels, ensure that the new levels keep this property.
                                                 ##
    RCUTILS_LOG_SEVERITY_UNSET = 0, ## < The unset log level
    RCUTILS_LOG_SEVERITY_DEBUG = 10, ## < The debug log level
    RCUTILS_LOG_SEVERITY_INFO = 20, ## < The info log level
    RCUTILS_LOG_SEVERITY_WARN = 30, ## < The warn log level
    RCUTILS_LOG_SEVERITY_ERROR = 40, ## < The error log level
    RCUTILS_LOG_SEVERITY_FATAL = 50 ## < The fatal log level



proc rcutils_logging_severity_level_from_string*(severity_string: cstring;
    allocator: rcutils_allocator_t; severity: ptr cint): rcutils_ret_t {.
    importc: "rcutils_logging_severity_level_from_string", header: "logging.h".}
type                          ##  The names of severity levels.

  rcutils_logging_output_handler_t* = proc (a1: ptr rcutils_log_location_t; a2: cint;
      a3: cstring; a4: rcutils_time_point_value_t; a5: cstring; a6: varargs[pointer]) ##
                              ##  The function signature to log messages.
                              ##
                              ##  \param[in] location The location information about where the log came from
                              ##  \param[in] severity The severity of the log message expressed as an integer
                              ##  \param[in] name The name of the logger that this message came from
                              ##  \param[in] timestamp The time at which the log message was generated
                              ##  \param[in] format The list of arguments to insert into the formatted log message
                              ##  \param[in] args The variable argument list
                              ##
  ##  location
  ##  severity
  ##  name
  ##  timestamp
  ##  format
  ##  args


proc rcutils_logging_get_output_handler*(): rcutils_logging_output_handler_t {.
    importc: "rcutils_logging_get_output_handler", header: "logging.h".}

proc rcutils_logging_set_output_handler*(function: rcutils_logging_output_handler_t) {.
    importc: "rcutils_logging_set_output_handler", header: "logging.h".}

proc rcutils_logging_format_message*(location: ptr rcutils_log_location_t;
                                    severity: cint; name: cstring;
                                    timestamp: rcutils_time_point_value_t;
                                    msg: cstring;
                                    logging_output: ptr rcutils_char_array_t): rcutils_ret_t {.
    importc: "rcutils_logging_format_message", header: "logging.h".}

proc rcutils_logging_get_default_logger_level*(): cint {.
    importc: "rcutils_logging_get_default_logger_level", header: "logging.h".}

proc rcutils_logging_set_default_logger_level*(level: cint) {.
    importc: "rcutils_logging_set_default_logger_level", header: "logging.h".}

proc rcutils_logging_get_logger_level*(name: cstring): cint {.
    importc: "rcutils_logging_get_logger_level", header: "logging.h".}

proc rcutils_logging_get_logger_leveln*(name: cstring; name_length: csize_t): cint {.
    importc: "rcutils_logging_get_logger_leveln", header: "logging.h".}

proc rcutils_logging_set_logger_level*(name: cstring; level: cint): rcutils_ret_t {.
    importc: "rcutils_logging_set_logger_level", header: "logging.h".}

proc rcutils_logging_logger_is_enabled_for*(name: cstring; severity: cint): bool {.
    importc: "rcutils_logging_logger_is_enabled_for", header: "logging.h".}

proc rcutils_logging_get_logger_effective_level*(name: cstring): cint {.
    importc: "rcutils_logging_get_logger_effective_level", header: "logging.h".}

proc rcutils_log_internal*(location: ptr rcutils_log_location_t; severity: cint;
                          name: cstring; format: cstring) {.varargs,
    importc: "rcutils_log_internal", header: "logging.h".}

proc rcutils_log*(location: ptr rcutils_log_location_t; severity: cint; name: cstring;
                 format: cstring) {.varargs, importc: "rcutils_log",
                                  header: "logging.h".}

proc rcutils_logging_console_output_handler*(
    location: ptr rcutils_log_location_t; severity: cint; name: cstring;
    timestamp: rcutils_time_point_value_t; format: cstring; args: varargs[pointer]) {.
    importc: "rcutils_logging_console_output_handler", header: "logging.h".}
##  Get the current output handler.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \return The function pointer of the current output handler.
##
##  Set the current output handler.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] function The function pointer of the output handler to be used.
##
##  Formats a log message according to RCUTILS_CONSOLE_OUTPUT_FORMAT
##
##  A formatter that is meant to be used by an output handler to format a log message to the match
##  the format specified in RCUTILS_CONSOLE_OUTPUT_FORMAT by performing token replacement.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | Yes
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] location The location information about where the log came from
##  \param[in] severity The severity of the log message expressed as an integer
##  \param[in] name The name of the logger that this message came from
##  \param[in] timestamp The time at which the log message was generated
##  \param[in] msg The message being logged
##  \param[out] logging_output An output buffer for the formatted message
##  \return #RCUTILS_RET_OK if successful.
##  \return #RCUTILS_RET_BAD_ALLOC if memory allocation error occured
##
##  Get the default level for loggers.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \return The level.
##
##  Set the default severity level for loggers.
##
##  If the severity level requested is `RCUTILS_LOG_SEVERITY_UNSET`, the default
##  value for the default logger (`RCUTILS_DEFAULT_LOGGER_DEFAULT_LEVEL`)
##  will be restored instead.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] level The level to be used.
##
##  Get the severity level for a logger.
##
##  This considers the severity level of the specifed logger only.
##  To get the effective level of a logger given the severity level of its
##  ancestors, see rcutils_logging_get_logger_effective_level().
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] name The name of the logger, must be null terminated c string
##  \return The level of the logger if it has been set, or
##  \return `RCUTILS_LOG_SEVERITY_UNSET` if unset, or
##  \return the default logger level for an empty name, or
##  \return -1 on invalid arguments, or
##  \return -1 if an error occurred
##
##  Get the level for a logger and its name length.
##
##  Identical to rcutils_logging_get_logger_level() but without
##  relying on the logger name to be a null terminated c string.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] name The name of the logger
##  \param[in] name_length Logger name length
##  \return The level of the logger if it has been set, or
##  \return `RCUTILS_LOG_SEVERITY_UNSET` if unset, or
##  \return the default logger level for an empty name, or
##  \return -1 on invalid arguments, or
##  \return -1 if an error occurred
##
##  Set the severity level for a logger.
##
##  If an empty string is specified as the name, the default logger level will be set.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | Yes
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] name The name of the logger, must be null terminated c string.
##  \param[in] level The level to be used.
##  \return `RCUTILS_RET_OK` if successful, or
##  \return `RCUTILS_RET_INVALID_ARGUMENT` on invalid arguments, or
##  \return `RCUTILS_RET_LOGGING_SEVERITY_MAP_INVALID` if severity map invalid, or
##  \return `RCUTILS_RET_ERROR` if an unspecified error occured
##
##  Determine if a logger is enabled for a severity level.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] name The name of the logger, must be null terminated c string or NULL.
##  \param[in] severity The severity level.
##
##  \return `true` if the logger is enabled for the level, or
##  \return `false` otherwise.
##
##  Determine the effective level for a logger.
##
##  The effective level is determined as the severity level of
##  the logger if it is set, otherwise it is the first specified severity
##  level of the logger's ancestors, starting with its closest ancestor.
##  The ancestor hierarchy is signified by logger names being separated by dots:
##  a logger named `x` is an ancestor of `x.y`, and both `x` and `x.y` are
##  ancestors of `x.y.z`, etc.
##  If the level has not been set for the logger nor any of its
##  ancestors, the default level is used.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, provided logging system is already initialized
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] name The name of the logger, must be null terminated c string.
##
##  \return The level, or
##  \return -1 on invalid arguments, or
##  \return -1 if an error occurred.
##
##  Internal call to log a message.
##
##  Unconditionally log a message.
##  This is an internal function, and assumes that the caller has already called
##  rcutils_logging_logger_is_enabled_for().
##  End-user software should never call this, and instead should call rcutils_log()
##  or one of the RCUTILS_LOG_ macros.
##
##  The attributes of this function are influenced by the currently set output handler.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, for formatted outputs <= 1023 characters
##                     | Yes, for formatted outputs >= 1024 characters
##  Thread-Safe        | No
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] location The pointer to the location struct or NULL
##  \param[in] severity The severity level
##  \param[in] name The name of the logger, must be null terminated c string or NULL
##  \param[in] format The format string
##  \param[in] ... The variable arguments
##
##  @cond Doxygen_Suppress
##  Log a message.
##
##  The attributes of this function are influenced by the currently set output handler.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No, for formatted outputs <= 1023 characters
##                     | Yes, for formatted outputs >= 1024 characters
##  Thread-Safe        | Yes, with itself [1]
##  Uses Atomics       | No
##  Lock-Free          | Yes
##  <i>[1] should be thread-safe with itself but not with other logging functions</i>
##
##  This should be thread-safe with itself, but is not thread-safe with other
##  logging functions that do things like set logger levels.
##
##  \todo There are no thread-safety gurantees between this function and other
##    logging functions in rcutils, even though it is likely users are calling
##    them concurrently today.
##    We need to revisit these functions with respect to this issue and make
##    guarantees where we can, and change functions higher in the stack to
##    provide the thread-safety where we cannot.
##
##  \param[in] location The pointer to the location struct or NULL
##  \param[in] severity The severity level
##  \param[in] name The name of the logger, must be null terminated c string or NULL
##  \param[in] format The format string
##  \param[in] ... The variable arguments
##
##  @cond Doxygen_Suppress
##  The default output handler outputs log messages to the standard streams.
##
##  The messages with a severity level `DEBUG` and `INFO` are written to `stdout`.
##  The messages with a severity level `WARN`, `ERROR`, and `FATAL` are written
##  to `stderr`.
##  The console output format of the logged message can be configured through
##  the `RCUTILS_CONSOLE_OUTPUT_FORMAT` environment variable: see
##  rcutils_logging_initialize_with_allocator() for details.
##  For configuring if using colours or not, `RCUTILS_COLORIZED_OUTPUT` can be used:
##  see rcutils_logging_initialize_with_allocator() for details.
##
##  <hr>
##  Attribute          | Adherence
##  ------------------ | -------------
##  Allocates Memory   | No
##  Thread-Safe        | Yes, if the underlying *printf functions are
##  Uses Atomics       | No
##  Lock-Free          | Yes
##
##  \param[in] location The pointer to the location struct or NULL
##  \param[in] severity The severity level
##  \param[in] name The name of the logger, must be null terminated c string
##  \param[in] timestamp The timestamp for when the log message was made
##  \param[in] format The format string
##  \param[in] args The `va_list` used by the logger
## 