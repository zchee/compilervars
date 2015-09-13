#!/bin/sh
#
# To make properly if the exercise of copyright, intel guys?
#

# Cleanup install path
PROD_DIR="/opt/intel/mac"

# Cleanup arch flags
TARGET_ARCH=
TARGET_PLATFORM=linux

# For FreeBSD
if [ -e $PROD_DIR/bin/intel64/icl_fbsd.cfg ]; then
    TARGET_ARCH=intel64
    TARGET_PLATFORM=freebsd
fi

COMPILERVARS_ARGV=$#
if [ $# -eq 0 ]; then
  if [ "$COMPILERVARS_ARCHITECTURE" != '' ]; then
    TARGET_ARCH=$COMPILERVARS_ARCHITECTURE
  fi
  if [ "$COMPILERVARS_PLATFORM" != '' ]; then
    TARGET_PLATFORM=$COMPILERVARS_PLATFORM
  fi
fi

while [ $# -gt 0 ]
do
opt="$1"
case $opt in 
  -arch)
  shift
  TARGET_ARCH="$1"
  shift
  ;;
  -platform)
  shift
  TARGET_PLATFORM="$1"
  shift
  ;; 
  *)
  TARGET_ARCH="$1"
  shift
  ;;
esac
done

if [ ! -e $PROD_DIR/bin/intel64/icl_fbsd.cfg ] && \
   [ "$TARGET_ARCH" != "ia32" -a "$TARGET_ARCH" != "intel64" -o \
     "$TARGET_PLATFORM" != "android" -a "$TARGET_PLATFORM" != "linux" -a "$TARGET_PLATFORM" != "mac" ]; then

  echo "compilervars.sh <arch> [-arch <arch>] [-platform <platform>]"
  echo ""
  echo "  <arch> must be one of the following:"
  echo "      ia32           : Set up for IA-32 target."
  echo "      intel64        : Set up for Intel(R)64 target."
  echo "  <platform> must be of the following:"
  echo "      linux          : Set to Linux target."
  echo "      mac            : Set to Mac target."
  echo "      android        : Set to Android target."
  echo ""
  echo "If the arguments to the sourced script are ignored (consult docs"
  echo "for your shell) the alternative way to specify target is environment"
  echo "variables COMPILERVARS_ARCHITECTURE to pass <arch> to the script"
  echo "and COMPILERVARS_PLATFORM to pass <platform>"

  return 1
elif [ -e $PROD_DIR/bin/intel64/icl_fbsd.cfg ] && \
     [ "$TARGET_ARCH" != "intel64" -o \
       "$TARGET_PLATFORM" != "freebsd" ]; then

  echo "compilervars.sh <arch> [-arch <arch>] [-platform <platform>]"
  echo ""
  echo "  <arch> must be one of the following:"
  echo "      intel64        : Set up for Intel(R)64 target."
  echo "  <platform> must be of the following:"
  echo "      freebsd        : Set to FreeBSD target."
  echo ""
  echo "If the arguments to the sourced script are ignored (consult docs"
  echo "for your shell) the alternative way to specify target is environment"
  echo "variables COMPILERVARS_ARCHITECTURE to pass <arch> to the script"
  echo "and COMPILERVARS_PLATFORM to pass <platform>"

  return 1
fi

if [ "$TARGET_PLATFORM" = "mac" ]; then
  TARGET_PLATFORM="linux"
fi

if [ $COMPILERVARS_ARGV -eq 0 ] ; then
  #pass default values via COMPILERVARS_*
  if [ "$COMPILERVARS_ARCHITECTURE" = '' ]; then
    COMPILERVARS_ARCHITECTURE=$TARGET_ARCH
  fi
  if [ "$COMPILERVARS_PLATFORM" = '' ]; then
    COMPILERVARS_PLATFORM=$TARGET_PLATFORM
  fi
  TARGET_ARCH=
  TARGET_PLATFORM=
fi

if [ -e $PROD_DIR/daal/bin/daalvars.sh ]; then
   . $PROD_DIR/daal/bin/daalvars.sh $TARGET_ARCH 
fi
if [ -e $PROD_DIR/../../debugger_2016/bin/debuggervars.sh ]; then
  . $PROD_DIR/../../debugger_2016/bin/debuggervars.sh $TARGET_ARCH 
fi
if [ -e $PROD_DIR/tbb/bin/tbbvars.sh ]; then
   . $PROD_DIR/tbb/bin/tbbvars.sh $TARGET_ARCH 
fi
if [ -e $PROD_DIR/mkl/bin/mklvars.sh ]; then
  . $PROD_DIR/mkl/bin/mklvars.sh $TARGET_ARCH 
fi
if [ -e $PROD_DIR/ipp/bin/ippvars.sh ]; then
  . $PROD_DIR/ipp/bin/ippvars.sh $TARGET_ARCH $TARGET_PLATFORM
fi
if [ -e $PROD_DIR/pkg_bin/compilervars_arch.sh ]; then
    . $PROD_DIR/pkg_bin/compilervars_arch.sh $TARGET_ARCH $TARGET_PLATFORM
fi
