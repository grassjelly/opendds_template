#!/usr/bin/env bash
echo ""
echo "Have you source your OpenDDS env ($ source OpenDDS/setenv.sh) ? "
echo "Press [ENTER] to continue"
read

#generate codes
mkdir gen && cd idl
cp $(find . -name '*.mpc') ../gen
cp $(find . -name '*.idl') ../gen
cd ../gen
$ACE_ROOT/bin/mwc.pl -type gnuace
make
echo "Code Generated"

#Build and Compile
echo "Building Now"
cd ..
mkdir -p build && cd build
cmake ..
make
