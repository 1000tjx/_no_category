#!/bin/sh

PROJECT_PATH="$PWD/$1"
GODOT_BRANCH_NAME=$2

if [ -d "$PROJECT_PATH" ]; then
  echo "$PROJECT_PATH is already exists"
  exit
fi

SRCPATH="$PROJECT_PATH/source"
EXPPATH="$PROJECT_PATH/export"

## create folderstructure
if [ ! -d "$EXPPATH" ]; then
  mkdir -p "$EXPPATH" 
  mkdir -p "$EXPPATH/executes"
  mkdir -p "$EXPPATH/libs"
  cd "$EXPPATH/executes"
  mkdir -p HTML Windows Linux Android
  cd ../..
fi
if [ ! -d "$SRCPATH" ]; then
  mkdir -p "$SRCPATH"
  mkdir -p "$SRCPATH/native_librarys"
fi


##Clone all godot-dependencys

cd "$SRCPATH"

git clone --recursive https://github.com/GodotNativeTools/godot-cpp -b $GODOT_BRANCH_NAME



##Build C++-Bindings

cd godot-cpp/

if [ ! -f bin/libgodot-cpp.linux.debug.64.a ]; then
    scons generate_bindings=yes target=debug bits=64 -j8
fi

if [ ! -f bin/libgodot-cpp.linux.debug.32.a ]; then
    scons generate_bindings=yes target=debug bits=32 -j8
fi

if [ ! -f bin/libgodot-cpp.linux.release.64.a ]; then
    scons generate_bindings=yes target=release bits=64 -j8
fi

if [ ! -f bin/libgodot-cpp.linux.release.32.a ]; then
    scons generate_bindings=yes target=release bits=32 -j8
fi


cd ../

echo Everything is done, Terminal can be closed
exit 0