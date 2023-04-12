# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import rcutils
import rcutils/clib

suite "compiles":
  test "time":
    var time: rcutils_time_point_value_t
    let ret = rcutils_system_time_now(addr time)
    check ret == 0
    check time.int64 != 0

  # test "allocator":
  #   check 5 + 5 == 10
  #   var ac = rcutils_get_default_allocator()
  #   check rcutils_allocator_is_valid(addr ac) == true

