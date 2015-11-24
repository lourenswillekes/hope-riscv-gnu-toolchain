/* Definitions for RISC-V GNU/Linux systems with ELF format.
   Copyright (C) 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006,
   2007, 2008, 2010, 2011 Free Software Foundation, Inc.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3, or (at your option)
any later version.

GCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING3.  If not see
<http://www.gnu.org/licenses/>.  */

#undef WCHAR_TYPE
#define WCHAR_TYPE "int"

#undef WCHAR_TYPE_SIZE
#define WCHAR_TYPE_SIZE 32

#define TARGET_OS_CPP_BUILTINS()				\
  do {								\
    GNU_USER_TARGET_OS_CPP_BUILTINS();				\
    /* The GNU C++ standard library requires this.  */		\
    if (c_dialect_cxx ())					\
      builtin_define ("_GNU_SOURCE");				\
  } while (0)

#undef SUBTARGET_CPP_SPEC
#define SUBTARGET_CPP_SPEC "%{posix:-D_POSIX_SOURCE} %{pthread:-D_REENTRANT}"

#define GLIBC_DYNAMIC_LINKER "/lib/ld.so.1"

/* Borrowed from sparc/linux.h */
#undef LINK_SPEC
#define LINK_SPEC \
  "%{shared:-shared} \
  %{!shared: \
    %{!static: \
      %{rdynamic:-export-dynamic} \
      -dynamic-linker " GNU_USER_DYNAMIC_LINKER "} \
      %{static:-static}}"

#undef LIB_SPEC
#define LIB_SPEC "\
%{pthread:-lpthread} \
%{shared:-lc} \
%{!shared: \
  %{profile:-lc_p} %{!profile:-lc}}"

#undef STARTFILE_SPEC
#define STARTFILE_SPEC \
  "%{" OPT_ARCH64 ": \
     %{!shared: %{pg|p|profile:gcrt1.o%s;pie:Scrt1.o%s;:crt1.o%s}} \
     crti.o%s %{static:crtbeginT.o%s;shared|pie:crtbeginS.o%s;:crtbegin.o%s} } \
  %{" OPT_ARCH32 ": \
     %{!shared: %{pg|p|profile:gcrt1.o%s;pie:Scrt1.o%s;:crt1.o%s}} \
     crti.o%s %{static:32/crtbeginT.o%s;shared|pie:32/crtbeginS.o%s;:32/crtbegin.o%s} }"

/* Similar to standard Linux, but adding -ffast-math support.  */
#undef  ENDFILE_SPEC
#define ENDFILE_SPEC \
   "%{" OPT_ARCH64 ":%{shared|pie:crtendS.o%s;:crtend.o%s} crtn.o%s} \
     %{" OPT_ARCH32 ":%{shared|pie:32/crtendS.o%s;:32/crtend.o%s} 32/crtn.o%s}"
