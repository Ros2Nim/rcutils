import std/os, std/strutils, std/strformat
import ants/language_v1

static:
  const python_code = dedent"""
    import em
    em.invoke(
      [
        '-o', '../../deps/rcutils/include/rcutils/logging_macros.h',
        '-D', 'rcutils_module_path="../../deps/rcutils/src"',
        '../../deps/rcutils/resource/logging_macros.h.em'
      ]
    )
    """
  assert "" == staticExec("python3 -c " & quoteShellCommand([python_code]))

{.passC: "-Ideps/rcutils/include".}

const baseDir = "deps" / "rcutils" / "src"  

{.compile: baseDir / "allocator.c".}
{.compile: baseDir / "array_list.c".}
{.compile: baseDir / "char_array.c".}
{.compile: baseDir / "cmdline_parser.c".}
{.compile: baseDir / "env.c".}
{.compile: baseDir / "error_handling.c".}
{.compile: baseDir / "filesystem.c".}
{.compile: baseDir / "find.c".}
{.compile: baseDir / "format_string.c".}
{.compile: baseDir / "hash_map.c".}
{.compile: baseDir / "logging.c".}
{.compile: baseDir / "process.c".}
{.compile: baseDir / "qsort.c".}
{.compile: baseDir / "repl_str.c".}
{.compile: baseDir / "sha256.c".}
{.compile: baseDir / "shared_library.c".}
{.compile: baseDir / "snprintf.c".}
{.compile: baseDir / "split.c".}
{.compile: baseDir / "strcasecmp.c".}
{.compile: baseDir / "strdup.c".}
{.compile: baseDir / "strerror.c".}
{.compile: baseDir / "string_array.c".}
{.compile: baseDir / "string_map.c".}
{.compile: baseDir / "testing/fault_injection.c".}
{.compile: baseDir / "time.c".}
{.compile: baseDir / "uint8_array.c".}

when defined(windows):
  {.compile: baseDir / "time_win32.c".}
else:
  {.compile: baseDir / "time_unix.c".}

