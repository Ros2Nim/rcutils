# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import os
import rcutils
import rcutils/clib

suite "compiles":
  test "time":
    var time: rcutils_time_point_value_t
    let ret = rcutils_system_time_now(addr time)
    check ret == 0
    check time.int64 != 0

  test "env":
    check true == rcutils_set_env("test".cstring, "valid".cstring)
    check getEnv("test") == "valid"
    
  test "env":
    check true == rcutils_set_env("test".cstring, "valid".cstring)
    check getEnv("test") == "valid"
    
  test "logging":
    check rcutils_logging_initialize() == 0

    var loc: rcutils_log_location_t
    loc.function_name = "foo".cstring
    loc.file_name = "none".cstring
    loc.line_number = 137

    rcutils_log(addr(loc), RCUTILS_LOG_SEVERITY_INFO.cint,
                            "logging".cstring,
                            "testing".cstring)
    

  # test "allocator":
  #   check 5 + 5 == 10
  #   var ac = rcutils_get_default_allocator()
  #   check rcutils_allocator_is_valid(addr ac) == true

