# Package

version       = "0.4.0"
author        = "Jaremy Creechley"
description   = "Rcutils wrapper for Nim"
license       = "MIT"

srcDir        = "src"
skipDirs      = @["deps"]


# Dependencies
requires "nim >= 1.6.0"
requires "ants"

# before install:
#   let cmakes = getEnv("NIMBLE_CMAKES").split(",")
#   echo "BEFORE INSTALL: ", cmakes 
#   if "rcutils" in cmakes:
#     echo "INSTALL CLIB"
#   else:
#     echo "DON'T INSTALL CLIB"