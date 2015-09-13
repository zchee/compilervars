#!/bin/bash
set -x

source ./compilervars.sh intel64

echo "========== LIBRARY_PATH =========="
echo $LIBRARY_PATH

echo "========== DYLD_LIBRARY_PATH =========="
echo $DYLD_LIBRARY_PATH

echo "========== PATH =========="
echo $PATH

echo "========== TARGET_ARCH =========="
echo $TARGET_ARCH

echo "========== TARGET_PLATFORM =========="
echo $TARGET_PLATFORM

