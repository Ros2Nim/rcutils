# Package

version       = "0.4.1"
author        = "Jaremy Creechley"
description   = "Rcutils wrapper for Nim"
license       = "MIT"

srcDir        = "src"
skipDirs      = @["deps"]

## build dynamic lib
# installExt    = @["nim"]
# namedBin["rcutils/clib"] = "rcutils".toDLL

# Dependencies
requires "nim >= 1.6.0"
requires "ants"
