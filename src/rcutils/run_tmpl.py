import em
import os
directory = os.getcwd()
print("PYTHON CWD: ", directory)

em.invoke(
  [
    '-o', '../../deps/rcutils/include/rcutils/logging_macros.h',
    '-D', 'rcutils_module_path="../../deps/rcutils/src"',
    '../../deps/rcutils/resource/logging_macros.h.em'
  ]
)

