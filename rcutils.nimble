# Package

version       = "0.1.0"
author        = "Jaremy Creechley"
description   = "Rcutils wrapper for Nim"
license       = "MIT"

srcDir        = "src"
skipDirs      = @["doc"]
installExt = @["nim"]
bin = @["rcutils"]


# Dependencies

requires "nim >= 1.6.0"
