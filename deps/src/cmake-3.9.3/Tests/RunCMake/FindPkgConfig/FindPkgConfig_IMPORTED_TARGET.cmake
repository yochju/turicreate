cmake_minimum_required(VERSION 3.5)

project(FindPkgConfig_IMPORTED_TARGET C)

find_package(PkgConfig REQUIRED)
pkg_check_modules(NCURSES IMPORTED_TARGET QUIET ncurses)

if (NCURSES_FOUND)
  set(tgt PkgConfig::NCURSES)
  if (NOT TARGET ${tgt})
    message(FATAL_ERROR "FindPkgConfig found ncurses, but did not create an imported target for it")
  endif ()
  set(prop_found FALSE)
  foreach (prop IN ITEMS INTERFACE_INCLUDE_DIRECTORIES INTERFACE_LINK_LIBRARIES INTERFACE_COMPILE_OPTIONS)
    get_target_property(value ${tgt} ${prop})
    if (value)
      message(STATUS "Found property ${prop} on target: ${value}")
      set(prop_found TRUE)
    endif ()
  endforeach ()
  if (NOT prop_found)
    message(FATAL_ERROR "target ${tgt} found, but it has no properties")
  endif ()
else ()
  message(STATUS "skipping test; ncurses not found")
endif ()